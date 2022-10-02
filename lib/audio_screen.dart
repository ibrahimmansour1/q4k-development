import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance
        .ref('/material/${widget.subjectAudioName}/audio')
        .listAll();
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
                                onTap: (() => Navigator.push(
                                    context,
                                    (MaterialPageRoute(
                                        builder: (context) => Audio(
                                            subjectAudioName:
                                                widget.subjectAudioName))))),
                                child: ListTile(
                                  title: Text(file.name),
                                  trailing: IconButton(
                                    icon: Icon(Icons.download),
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
  void openAudio(BuildContext context, String subjectAudioName) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => AudioScreen(
                  subjectAudioName: widget.subjectAudioName,
                )),
      );
  Future downloadFile(int index, Reference ref) async {
    final ref = FirebaseStorage.instance.ref();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');
    await ref.writeToFile(file);

    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
          content: Text(
        'Downloaded ${ref.name}',
      )),
    );
  }
}
