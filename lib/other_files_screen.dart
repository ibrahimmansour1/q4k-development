import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:q4k/audio_player.dart';

import '../../constants.dart';

class OtherFilesScreen extends StatefulWidget {
  const OtherFilesScreen({super.key, required this.subjectFileName});
  final String subjectFileName;

  @override
  State<OtherFilesScreen> createState() => _OtherFilesScreenState();
}

class _OtherFilesScreenState extends State<OtherFilesScreen> {
  var _openResult = 'Unknown';

  Future<void> openFile() async {
    var filePath = r'/material/${widget.subjectFileName}/others';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      filePath = result.files.single.path!;
    } else {
      // User canceled the picker
    }
    final file = await OpenFile.open(filePath);
    // print(file.message);

    setState(() {
      // _openResult = "type=${file.type}  message=${file.message}";
    });
  }

  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance
        .ref('/material/${widget.subjectFileName}/others')
        .listAll();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Others',
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
                                onTap: (() => openFile()),
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
                                      IconButton(
                                        icon: Icon(
                                          Icons.download,
                                        ),
                                        onPressed: () {},
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

  // Future downloadFile(int index, Reference ref) async {
  //   // final ref = FirebaseStorage.instance.ref();

  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('/storage/emulated/0/Download/${ref.name}');
  //   await ref.writeToFile(file);

  //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
  //     SnackBar(
  //         content: Text(
  //       'Downloaded ${ref.name}',
  //     )),
  //   );
  // }
}
