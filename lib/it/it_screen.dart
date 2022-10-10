import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:q4k/categories_screen.dart';
import 'package:q4k/test.dart';
import 'package:q4k/constants.dart';

class IT extends StatefulWidget {
  const IT({super.key});

  @override
  State<IT> createState() => _ITState();
}

class _ITState extends State<IT> {
  @override
  Widget build(BuildContext context) {
    List<String> subject_name = [
      'Computer Graphics',
      'Image Processing',
      'Software Engineering',
      'Wireless and Mobile Computing',
      'Distributed and Object Databases',
      'Web Programming',
    ];

    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text(
          'IT',
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
                itemBuilder: (context, index) => ItSubjectCard(
                      subject_name: subject_name,
                      onPressed: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesScreen(
                                    subjectName: subject_name[index]
                                        .toLowerCase()
                                        .replaceAll(" ", "_"),
                                  )),
                        );
                      }),
                      index: index,
                    )),
          ),
        ]),
      ),
    );
  }
}

class ItSubjectCard extends StatelessWidget {
  const ItSubjectCard({
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
              color: primaryColor,
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
                    // fontWeight: FontWeight.bold,
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
