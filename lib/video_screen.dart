
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:q4k/models/video_model.dart';
import 'package:q4k/youtube_video_player.dart';

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
    final videos = data.data()!['videos'];
    for (var video in videos) {
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
        body: ListView.builder(
          itemBuilder: (context, index) {
        return InkWell(
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
        );
          },
          itemCount: videoModels.length,
        ));
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
