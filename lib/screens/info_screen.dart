import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

import 'package:q4k/audio_screen.dart';
import 'package:q4k/capitalize_extention.dart';
import 'package:q4k/pdf_screen.dart';
import 'package:q4k/youtube_video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants.dart';

class InfoScreen extends StatelessWidget {
  InfoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Info",
          style: TextStyle(
              color: lightColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "السلام عليكم ورحمة الله وبركاته",
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "الغرض من البرنامج إنك تلاقي كل اللي محتاجه علشان تذاكر، وأي ملحوظة أو إضافة أو مشكلة تواجهك في البرنامج كلمنى علشان نحلها إن شاء الله. أخيرًا، لو استفدت من البرنامج دعوة حلوة الله 💖",
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "",
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "المطورون:",
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.telegram_outlined,
                        ),
                        color: primaryColor,
                        onPressed: () async {
                          // _launchUrl();
                          String url = "https://t.me/ibrahim58563";
                          print("launchingUrl: $url");
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.facebook,
                        ),
                        color: primaryColor,
                        onPressed: () async {
                          // _launchUrl();
                          String url =
                              "https://www.facebook.com/profile.php?id=100064525956308";
                          print("launchingUrl: $url");
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        },
                      ),
                      Spacer(),
                      Text(
                        "إبراهيم منصور",
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.telegram_outlined,
                        ),
                        color: primaryColor,
                        onPressed: () async {
                          // _launchUrl();
                          String url = "https://t.me/FYZOO";
                          print("launchingUrl: $url");
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.facebook,
                        ),
                        color: primaryColor,
                        onPressed: () async {
                          // _launchUrl();
                          String url =
                              "https://www.facebook.com/abdallah.fayez.946";
                          print("launchingUrl: $url");
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        },
                      ),
                      Spacer(),
                      Text(
                        "عبدالله فايز",
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // final Uri _url = Uri.parse('https://flutter.dev');

  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(_url)) {
  //     throw 'Could not launch $_url';
  //   }
  // }
}
