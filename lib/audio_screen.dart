import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:q4k/audio_player.dart';
import 'package:q4k/models/video_model.dart';
import 'package:q4k/pdf_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import 'models/audio_model.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key, required this.subjectAudioName});
  final String subjectAudioName;

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final List<AudioModel> audioModels = [];
  Future<dynamic> getData() async {
    final data = await FirebaseFirestore.instance
        .collection('materials')
        .doc(widget.subjectAudioName)
        .get();
    final audios = data.data()!['audios'];
    // audioModels.removeLast();
    if (data.data()!['audios'] == null) {
      if (!audioModels.contains(' ')) {
        audioModels.add(AudioModel(name: " ", url: ' '));
        setState(() {});
      }
    } else {
      for (var audio in audios) {
        final audioModel = AudioModel(name: audio['name'], url: audio['url']);
        audioModels.add(audioModel);
      }
      setState(() {});
    }
  }

  late Future<ListResult> futureFiles;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    getData();
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
            'Audio',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: lightColor,
            ),
          ),
        ),
        body: (audioModels.first.name == ' ')
            ? const Center(child: Text("Empty Folder"))
            : ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (() => Navigator.push(
                        context,
                        (MaterialPageRoute(
                            builder: (context) => Audio(
                                  url:
                                      "https://drive.google.com/uc?export=view&id=" +
                                          audioModels[index]
                                              .url
                                              .substring(32, 65),
                                  subjectAudioName: widget.subjectAudioName,
                                ))))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            audioModels[index].name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.play_arrow_rounded,
                          ),
                          // IconButton(
                          //   icon: Icon(
                          //     Icons.download,
                          //   ),
                          //   onPressed: () {},
                          // ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: audioModels.length,
              ));
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
            builder: (context) => AudioScreen(
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
