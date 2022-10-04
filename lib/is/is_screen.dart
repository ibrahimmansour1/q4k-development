import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:q4k/test.dart';
import 'package:q4k/constants.dart';

import '../categories_screen.dart';

class IS extends StatefulWidget {
  const IS({super.key});

  @override
  State<IS> createState() => _ISState();
}

class _ISState extends State<IS> {
  @override
  Widget build(BuildContext context) {
    List<String> subject_name = [
      'Software Engineering',
      'Computer Graphics',
      'Dession support system',
      'Quality assurance of IS',
      'IS strategy management & aculation',
      'Distributed databases systems',
    ];

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text(
          'IS',
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
                itemBuilder: (context, index) => ISSubjectCard(
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
                    )),
          ),
        ]),
      ),
    );
  }
}

class ISSubjectCard extends StatelessWidget {
  const ISSubjectCard({
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
              Padding(
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
            ],
          ),
        ),
      ),
    );
  }
}
