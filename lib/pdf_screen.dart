import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:q4k/firebase_api.dart';
import 'package:q4k/firebase_file.dart';
import 'package:q4k/pdf_viewer.dart';

import '../../constants.dart';
import 'api/pdf_api.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key, required this.subjectPdfName});
  final String subjectPdfName;

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  late Future<ListResult> futureFiles;
  late Future<List<FirebaseFile>> download;
  @override
  void initState() {
    super.initState();
    download = FirebaseApi.listAll('/material/${widget.subjectPdfName}/pdf');

    futureFiles = FirebaseStorage.instance
        .ref('/material/${widget.subjectPdfName}/pdf')
        .listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'PDF',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: babyBlueColor,
          ),
        ),
      ),
      body: FutureBuilder<ListResult>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Some error occured'),
                  );
                } else {
                  final files = snapshot.data!.items;
                  return Column(
                    children: [
                      buildHeader(files.length),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index) {
                          final file = files[index];

                          return Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final url =
                                      '/material/${widget.subjectPdfName}/pdf/${files[index].name}';
                                  final file = await PDFApi.loadFirebase(url);

                                  if (file == null) return;

                                  openPDF(context, file);
                                },
                                child: ListTile(
                                  title: Text(file.name),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.download,
                                    ),
                                    onPressed: () => downloadFile(index, file),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: files.length,
                      ))
                    ],
                  );
                }
            }
          }),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
  Widget buildHeader(int length) => ListTile(
        tileColor: primaryColor,
        title: Text(
          '$length Files',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: babyBlueColor,
          ),
        ),
        leading: Container(
          width: 52,
          height: 52,
          child: const Icon(
            Icons.copy,
            color: babyBlueColor,
          ),
        ),
      );
  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    await Dio().download(
      url,
      path,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        'Downloaded ${ref.name}',
      )),
    );
  }
}
