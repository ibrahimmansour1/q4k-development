import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:q4k/shared/local/cache_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared.dart';
import 'question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SubjectScreen(
                                    subjects: [
                                      'Algorithm design',
                                      'Soft Computing',
                                    ],
                                    department: 'CS',
                                  )));
                    },
                    color: appColor,
                    child: const Text(
                      'CS',
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SubjectScreen(
                                    subjects: [
                                      'Wireless',
                                    ],
                                    department: 'IT',
                                  )));
                    },
                    color: appColor,
                    child: const Text(
                      'IT',
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SubjectScreen(
                                    subjects: [
                                      'quality assurence',
                                      'is strategy',
                                      'Decision support',
                                    ],
                                    department: 'IS',
                                  )));
                    },
                    color: appColor,
                    child: const Text(
                      'IS',
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SubjectScreen(
                                    subjects: [
                                      '3D',
                                      'introToMM',
                                    ],
                                    department: 'MM',
                                  )));
                    },
                    color: appColor,
                    child: const Text(
                      'MM',
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SubjectScreen(
                                    subjects: [
                                      'computer graphics',
                                      'distributed DB',
                                      'image processing',
                                      'software engineer',
                                      'web programming'
                                    ],
                                    department: 'Common subjects',
                                  )));
                    },
                    color: appColor,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Common subjects',
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class SubjectScreen extends StatelessWidget {
  const SubjectScreen(
      {Key? key, required this.subjects, required this.department})
      : super(key: key);
  final List subjects;
  final String department;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsetsDirectional.only(top: 100,start: 30,end: 30),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (c, i) => Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => QuestionScreen(
                                      subject: subjects[i],
                                      department: department,
                                    )));
                      },
                      color: appColor,
                      child: Container(
                        margin:EdgeInsets.symmetric(vertical: 10),
                       // padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5.0),
                        child: Text(
                          '${subjects[i]}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (c, i) => const SizedBox(
                  height: 20.0,
                ),
            itemCount: subjects.length),
      ),
    );
  }
}
