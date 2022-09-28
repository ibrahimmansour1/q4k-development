import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../constants.dart';

class WebProgrammingAudio extends StatefulWidget {
  const WebProgrammingAudio({super.key});

  @override
  State<WebProgrammingAudio> createState() => _WebProgrammingAudioState();
}

class _WebProgrammingAudioState extends State<WebProgrammingAudio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'web programming audio',
          style: TextStyle(
              color: goldenColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          width: 400,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: primaryColor,
                              width: 3,
                              style: BorderStyle.solid,
                            )),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ]),
    );
  }
}
