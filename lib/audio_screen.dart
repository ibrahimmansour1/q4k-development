import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:q4k/api/audio_api.dart';
import 'package:q4k/audio_player.dart';
import 'package:path/path.dart';

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
    setAudio();
    futureFiles = FirebaseStorage.instance
        .ref('/material/${widget.subjectAudioName}/audio')
        .listAll();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    // listion to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }

  static Future<File> loadFirebase(String url) async {
    final refAudio = FirebaseStorage.instance.ref().child(url);
    final bytes = await refAudio.getData();

    return _storeFile(url, bytes!);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future setAudio() async {
    try {
      audioPlayer.setReleaseMode(ReleaseMode.loop);
      // final url = 'https://server6.mp3quran.net/thubti/001.mp3';
      // final url = '112.mp3';
      final ref = FirebaseStorage.instance.ref();

      final dir = await getApplicationDocumentsDirectory();
      // final file = File('${dir.path}/${ref.name}');
      final url = '/material/${widget.subjectAudioName}/audio/${ref.name}';
      final file = AudioApi.loadFirebase(url);
      await audioPlayer.setSourceUrl(url);
    } on FirebaseException catch (e) {
      print(e);
    }
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
                      Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) async {
                          final position = Duration(seconds: value.toInt());
                          await audioPlayer.seek(position);

                          await audioPlayer.resume();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(position)),
                            Text(formatTime(duration - position)),
                          ],
                        ),
                      ),
                      CircleAvatar(
                          radius: 35,
                          child: IconButton(
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow),
                            iconSize: 50,
                            onPressed: () async {
                              if (isPlaying) {
                                await audioPlayer.pause();
                              } else {
                                await audioPlayer.resume();
                              }
                            },
                          )),
                      Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index) {
                          final file = files[index];

                          return Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final url =
                                      '/material/${widget.subjectAudioName}/audio/${files[index].name}';
                                  final file = await AudioApi.loadFirebase(url);
                                  await audioPlayer.setSourceUrl(url);

                                  if (file == null) return;
                                  // openAudio(context, widget.subjectAudioName);
                                },
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
            builder: (context) => Audio(
                  subjectAudioName: '${widget.subjectAudioName}',
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

  String formatTime(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
