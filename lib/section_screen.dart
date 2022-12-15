import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:q4k/firebase_api.dart';
import 'package:q4k/firebase_file.dart';

import '../../constants.dart';

class SectionScreen extends StatefulWidget {
  const SectionScreen({super.key, required this.subjectFileName});

  final String subjectFileName;

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  late Future<ListResult> futureFiles;
  late Future<List<FirebaseFile>> download;

  Future<void> openFile({required Reference file}) async {
    final tempPath = await path.getTemporaryDirectory();
    final File tempFile = File("${tempPath.path}/${file.name}");
    await file.writeToFile(tempFile);
    final result = await OpenFile.open(tempFile.path);
    print(result.message);
  }

  @override
  void initState() {
    super.initState();
    download =
        FirebaseApi.listAll('/material/${widget.subjectFileName}/section');

    futureFiles = FirebaseStorage.instance
        .ref('/material/${widget.subjectFileName}/section')
        .listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Section',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: lightColor,
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
                    child: Text('Empty Folder'),
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
                                onTap: () => openFile(file: file),
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
                                        Icons.open_in_new,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.download,
                                        ),
                                        onPressed: () =>
                                            downloadFile(index, file),
                                      ),
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

  Widget buildHeader(int length) => ListTile(
        tileColor: primaryColor,
        title: Text(
          '$length Files',
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
      if (!await directory.exists()) {
        directory = (await path.getExternalStorageDirectory())!;
      }
    }
  } catch (err, stack) {
    print("Cannot get download folder path");
  }
  return directory!;
}
