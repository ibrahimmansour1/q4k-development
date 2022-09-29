import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:q4k/audio_screen.dart';
import 'package:q4k/it/image_processing/image_processing_audio.dart';
import 'package:q4k/it/image_processing/image_processing_pdf.dart';
import 'package:q4k/pdf_screen.dart';

import '../../constants.dart';
import 'it/computer_graphics/computer_graphics_audio.dart';
import 'it/computer_graphics/computer_graphics_pdf.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.subjectName});
  final String subjectName;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    void tapped(int index) {
      if (index == 1) {
        PdfScreen(
          subjectPdfName: widget.subjectName,
        );
      } else {
        AudioScreen(
          subjectAudioName: widget.subjectName,
        );
      }
    }

    List<Widget> test = [
      PdfScreen(
        subjectPdfName: widget.subjectName,
      ),
      AudioScreen(
        subjectAudioName: widget.subjectName,
      ),
    ];
    List<String> section_name = [
      'PDF',
      'Audio',
    ];
    List<String> pictures_url = [
      'https://www.pngitem.com/pimgs/m/534-5347598_pdf-icon-png-transparent-png.png',
      'https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/headphones.png',
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'IT',
          style: TextStyle(
              color: goldenColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          width: 400,
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 16),
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: CategoriesCardWidget(
                      pictures_url: pictures_url,
                      section_name: section_name,
                      index: index,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PdfScreen(
                                    subjectPdfName: widget.subjectName)));
                      },
                    ),
                  )),
        ),
      ]),
    );
  }
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
          height: 140,
          width: 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: primaryColor,
                width: 3,
                style: BorderStyle.solid,
              )),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              CachedNetworkImage(
                imageUrl: pictures_url[index],
                height: 110,
                width: 110,
              ),
              Text(
                section_name[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
