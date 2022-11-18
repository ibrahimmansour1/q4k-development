import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:q4k/button_widget.dart';
import 'package:q4k/firebase_api.dart';
import 'package:q4k/firebase_file.dart';
import 'package:q4k/models/pdf_model.dart';
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
  // late Future<ListResult> futureFiles;
  // late Future<List<FirebaseFile>> download;
  final List<PDFModel> pdfModels = [];
  Future<void> getData() async {
    final data = await FirebaseFirestore.instance
        .collection('materials')
        .doc(widget.subjectPdfName)
        .get();
    final pdfs = data.data()!['pdfs'];
    for (var pdf in pdfs) {
      final pdfModel = PDFModel(name: pdf['name'], url: pdf['url']);
      pdfModels.add(pdfModel);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // download = FirebaseApi.listAll('/material/${widget.subjectPdfName}/pdf');
    getData();
    // var futureFiles = FirebaseFirestore.instance
    //     .collection('materials')
    //     .doc(widget.subjectPdfName)
    //     .get();
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
            color: lightColor,
          ),
        ),
      ),
      body: FutureBuilder<void>(
          future: getData(),
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
                  final files = pdfModels;
                  return Column(
                    children: [
                      buildHeader(files.length),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index) {
                          final file = pdfModels[index];

                          return Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final url =
                                      pdfModels[index].url;
                                  final file = await PDFApi.loadNetwork(url);

                                  if (file == null) return;

                                  openPDF(context, file);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        file.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.menu_book_outlined,
                                      ),
                                      // IconButton(
                                      //   icon: Icon(
                                      //     Icons.download,
                                      //   ),
                                      //   onPressed: () =>
                                      //       downloadFile(index, file),
                                      // ),
                                    ],
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
        MaterialPageRoute(
            builder: (context) => PDFViewerPage(
                  file: file,
                )),
      );
  Widget buildHeader(int length) => ListTile(
        tileColor: primaryColor,
        title: Text(
          '$length Files',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: lightColor,
          ),
        ),
        leading: Container(
          width: 52,
          height: 52,
          child: const Icon(
            Icons.copy,
            color: lightColor,
          ),
        ),
      );
  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();
    final downloadDir = await getDownloadPath();
    final path = '${downloadDir.path}/${ref.name}';
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

Future<Directory> getDownloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      directory = await path.getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');
      // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
      // ignore: avoid_slow_async_io
      if (!await directory.exists())
        directory = (await path.getExternalStorageDirectory())!;
    }
  } catch (err, stack) {
    print("Cannot get download folder path");
  }
  return directory!;
}




// InkWell(
//                                 onTap: () async {
//                                   final url = pdfModels[index].url;
//                                   final file = await PDFApi.loadNetwork(url);

//                                   if (file == null) return;

//                                   openPDF(context, file);
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     // mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         file.name,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Spacer(),
//                                       Icon(
//                                         Icons.menu_book_outlined,
//                                       ),
//                                       IconButton(
//                                         icon: Icon(
//                                           Icons.download,
//                                         ),
//                                         onPressed: () =>
//                                             downloadFile(index, file),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),