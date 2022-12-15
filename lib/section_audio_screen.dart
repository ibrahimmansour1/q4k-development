import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:q4k/audio_player.dart';
import 'package:q4k/pdf_screen.dart';
import 'package:q4k/section_audio_player.dart';

import '../../constants.dart';

class SectionAudioScreen extends StatefulWidget {
  const SectionAudioScreen({super.key, required this.subjectAudioName});
  final String subjectAudioName;

  @override
  State<SectionAudioScreen> createState() => _SectionAudioScreenState();
}

class _SectionAudioScreenState extends State<SectionAudioScreen> {
  late Future<ListResult> futureFiles;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  void requestPermission() async {
    await Permission.storage.request();
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
    futureFiles = FirebaseStorage.instance
        .ref('/material/${widget.subjectAudioName}/section/audio')
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
        title: Text(
          "Section Audio",
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
                                onTap: (() => Navigator.push(
                                    context,
                                    (MaterialPageRoute(
                                        builder: (context) => SectionAudio(
                                            subjectAudioName:
                                                widget.subjectAudioName))))),
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
                                        Icons.play_arrow_rounded,
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
  void openAudio(BuildContext context, String subjectAudioName) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => SectionAudioScreen(
                  subjectAudioName: widget.subjectAudioName,
                )),
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
