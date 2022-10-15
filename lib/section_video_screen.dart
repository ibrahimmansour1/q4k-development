import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:q4k/models/video_model.dart';
import 'package:q4k/youtube_video_player.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class SectionVideoScreen extends StatefulWidget {
  const SectionVideoScreen({super.key, required this.subjectName});
  final String subjectName;

  @override
  State<SectionVideoScreen> createState() => _SectionVideoScreenState();
}

class _SectionVideoScreenState extends State<SectionVideoScreen> {
  final List<SectionVideoModel> sectionVideoModels = [];
  Future<void> getData() async {
    final data = await FirebaseFirestore.instance
        .collection('sections')
        .doc(widget.subjectName)
        .get();
    final videos = data.data()!['videos'];
    for (var video in videos) {
      final sectionVideoModel =
          SectionVideoModel(name: video['name'], url: video['url']);
      sectionVideoModels.add(sectionVideoModel);
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
            'Section Video',
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
                            url: sectionVideoModels[index].url,
                          ))))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      sectionVideoModels[index].name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    IconButton(
                      iconSize: 30,
                      icon: Image.network(
                        'https://cdn2.iconfinder.com/data/icons/social-media-2285/512/1_Youtube2_colored_svg-512.png',
                        height: 80,
                        width: 100,
                      ),
                      color: primaryColor,
                      onPressed: () async {
                        // _launchUrl();
                        String url = "${sectionVideoModels[index].url}";
                        print("launchingUrl: $url");
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                    ),
                    Icon(
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
          itemCount: sectionVideoModels.length,
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
