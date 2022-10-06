import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:q4k/audio_player.dart';

import '../../constants.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key, required this.subjectAudioName});
  final String subjectAudioName;

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
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
        .ref('/material/${widget.subjectAudioName}/audio')
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
          'Audio',
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
                                onTap: (() => Navigator.push(
                                    context,
                                    (MaterialPageRoute(
                                        builder: (context) => Audio(
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
