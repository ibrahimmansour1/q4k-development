import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:q4k/audio_screen.dart';
import 'package:q4k/capitalize_extention.dart';
import 'package:q4k/other_files_screen.dart';
import 'package:q4k/pdf_screen.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:q4k/video_screen.dart';
import 'package:q4k/youtube_video_player.dart';

import '../../constants.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.subjectName});
  final String subjectName;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> test = [
      PdfScreen(
        subjectPdfName: widget.subjectName,
      ),
      AudioScreen(
        subjectAudioName: widget.subjectName,
      ),
      VideoScreen(
        subjectName: widget.subjectName,
      ),
      OtherFilesScreen(
        subjectFileName: widget.subjectName,
      ),
    ];
    List<String> section_name = ['PDF', 'Audio', 'Video', 'Others'];
    List<String> pictures_url = [
      'https://cdn0.iconfinder.com/data/icons/font-awesome-solid-vol-2/512/file-pdf-512.png',
      'https://cdn4.iconfinder.com/data/icons/remixicon-media/24/headphone-fill-512.png',
      'https://cdn4.iconfinder.com/data/icons/48-bubbles/48/23.Videos-512.png',
      'https://cdn4.iconfinder.com/data/icons/48-bubbles/48/23.Videos-512.png',
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          capitalizeAllWord(widget.subjectName.replaceAll("_", " ")),
          style: TextStyle(
              color: lightColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          width: 400,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) => CategoriesCardWidget(
                    pictures_url: pictures_url,
                    section_name: section_name,
                    index: index,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => test[index]));
                    },
                  )),
        ),
      ]),
    );
  }
}

String capitalizeAllWord(String value) {
  var result = value[0].toUpperCase();
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " ") {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
    }
  }
  return result;
}

class CategoriesCardWidget extends StatelessWidget {
  const CategoriesCardWidget({
    super.key,
    required this.pictures_url,
    required this.section_name,
    required this.index,
    required this.onPressed,
  });

  final List<String> pictures_url;
  final List<String> section_name;
  final int index;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 100,
          width: 140,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(.3),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: primaryColor,
                width: 1,
                style: BorderStyle.solid,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: CachedNetworkImage(
                  imageUrl: pictures_url[index],
                  color: primaryColor,
                  height: 60,
                  width: 60,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                section_name[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
    );
  }
}
