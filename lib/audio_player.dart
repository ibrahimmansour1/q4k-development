import 'dart:developer';
import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Audio extends StatefulWidget {
  final String subjectAudioName;

  const Audio({super.key, required this.subjectAudioName});

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  late var duration = Duration.zero;
  var position = Duration.zero;
  int currentFileIndex = -1;

  final List<String> files = [
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/1.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/2.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/3.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/4.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/5.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/6.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/7.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/8.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/9.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/10.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/11.mp3",
  ];

  int getNextIndex() {
    if (files.length - 1 > currentFileIndex) {
      currentFileIndex++;
      log(currentFileIndex.toString(), name: "currentFileIndex");

      return currentFileIndex;
    } else {
      currentFileIndex = 0;
      log(currentFileIndex.toString(), name: "currentFileIndex");
      return currentFileIndex;
    }
  }

  Future<void> loadFiles() async {
    final futureFiles = await FirebaseStorage.instance.ref().listAll();

    futureFiles.items.map((e) async {
      log(e.fullPath, name: "e.fullPath");

      files.add(await e.getDownloadURL());
    });
    log(files.length.toString(), name: "files.length");
  }

  @override
  void initState() {
    super.initState();
    setAudio();
    loadFiles();

    /// listen to states: playing, paused, stopped
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
        if (state == PlayerState.completed) {
          setAudio();
        }
      });
    });


    // listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
    });

    // listion to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
        audioPlayer.resume();
      });
    });


  }

  Future setAudio() async {
   // audioPlayer.setReleaseMode(ReleaseMode.loop);
    String url = 'https://server6.mp3quran.net/thubti/001.mp3';
    audioPlayer.setVolume(1);
    final file = files[getNextIndex()];
    await audioPlayer.setSourceUrl(file);
  }

  @override
  void dispose() async {
    await audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds
                .clamp(0, position.inSeconds).toDouble(),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await audioPlayer.seek(position);
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
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.resume();
                  }
                },
              )),
        ],
      ),
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
