import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:q4k/question_library/screens/question_screen.dart';

notificationManager(context) {
  FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    String sub = event.data['subject'];
    String department = event.data['department'];
    print('==============================================================');

    print(sub);
 print(department);
    print('==============================================================');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => QuestionScreen(
                  department: department,
                  subject: sub,
                )));
  });
  //---------------------
  FirebaseMessaging.instance.getInitialMessage().then((value) {
if(value!=null){

  String sub = value?.data['subject'];
  String department = value?.data['department'];
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => QuestionScreen(
            department: department,
            subject: sub,
          )));
}


  });
}
