import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:q4k/test.dart';
import 'package:q4k/constants.dart';

import '../categories_screen.dart';

class MM extends StatefulWidget {
  const MM({super.key});

  @override
  State<MM> createState() => _MMState();
}

class _MMState extends State<MM> {
  @override
  Widget build(BuildContext context) {
    List<String> subject_name = [
      'Game Programming',
      'Principles of 2D Animation',
      'Introduction to Digital Video',
      'Cloud Computing',
      'Enterprise Architecture',
      'Interactive Multimedia Development',
    ];

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text(
          'MM',
          style: TextStyle(
              color: lightColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: 400,
            height: 1000,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: subject_name.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: lightColor,
                              width: 1,
                              style: BorderStyle.solid,
                            )),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            MMSubjectCard(
                              subject_name: subject_name,
                              index: index,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoriesScreen(
                                            subjectName: subject_name[index]
                                                .toLowerCase()
                                                .replaceAll(" ", "_"),
                                          )),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
        ]),
      ),
    );
  }
}

class MMSubjectCard extends StatelessWidget {
  const MMSubjectCard({
    super.key,
    required this.subject_name,
    required this.index,
    required this.onPressed,
  });

  final List<String> subject_name;
  final int index;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          subject_name[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: lightColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
