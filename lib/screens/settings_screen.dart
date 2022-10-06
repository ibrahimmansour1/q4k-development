import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:q4k/audio_screen.dart';
import 'package:q4k/capitalize_extention.dart';
import 'package:q4k/pdf_screen.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:q4k/youtube_video_player.dart';

import '../../constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Settings",
          style: TextStyle(
              color: lightColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Soon..",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }
}
