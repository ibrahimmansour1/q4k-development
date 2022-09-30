import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key, required this.subjectPdfName});
  final String subjectPdfName;

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  late Future<ListResult> futureFiles;
  @override
  void initState() {
    super.initState();
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
                              ListTile(
                                title: Text(file.name),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.download,
                                  ),
                                  onPressed: () => downloadFile(index, file),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 370,
                                height: 400,
                                child: PDF(
                                  enableSwipe: true,
                                  swipeHorizontal: true,
                                  autoSpacing: false,
                                  pageFling: true,
                                  pageSnap: true,
                                ).fromUrl(
                                    'https://www.cia.gov/library/abbottabad-compound/C2/C2FB97ADC83D3461648EA07238CA296E%CE%A9%C3%B3%CE%B4%20%C6%92%CE%98%C3%9C%E2%8C%90%C3%A1%CF%80%E2%88%A9%CE%B4%20%C6%92%CE%98%CE%B4%CF%86%CF%86%E2%88%A9%C3%AD.pdf'),
                              )
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
    final ref = FirebaseStorage.instance.ref();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');
    await ref.writeToFile(file);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        'Downloaded ${ref.name}',
      )),
    );
  }
}
