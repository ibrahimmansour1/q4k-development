import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:q4k/audio_player.dart';
import 'package:q4k/models/video_model.dart';
import 'package:q4k/youtube_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.subjectName});
  final String subjectName;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final List<VideoModel> videoModels = [];
  Future<void> getData() async {
    final data = await FirebaseFirestore.instance
        .collection('materials')
        .doc(widget.subjectName)
        .get();
    final Videos = data.data()!['videos'];
    for (var video in Videos) {
      final videoModel = VideoModel(name: video['name'], url: video['url']);
      videoModels.add(videoModel);
    }
    setState(() {});
  }

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
            'Video',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: lightColor,
            ),
          ),
        ),
        body: Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: (() => Navigator.push(
                      context,
                      (MaterialPageRoute(
                          builder: (context) => YoutubePlayerScreen(
                                url: videoModels[index].url,
                              ))))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          videoModels[index].name,
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
          itemCount: videoModels.length,
        )));
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
}
