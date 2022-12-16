import 'package:flutter/material.dart';


import '../cubit/answer_cubit.dart';
import '../shared.dart';
import 'home_screen.dart';


class QuestionScreen extends StatelessWidget {
  QuestionScreen({Key? key, required this.department, required this.subject})
      : super(key: key);
  final String department;
  final String subject;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          QuestionCubit.getAllData(department: department, subject: subject),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.isNotEmpty) {
            return Scaffold(
              backgroundColor:appColor,
              body: Container(
                color: appColor,
                margin: const EdgeInsetsDirectional.only(top: 5),
                child: PageViewScreen(
                    snapshot: snapshot, subject: subject, department: department),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text(
                  'No data!',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: appColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
