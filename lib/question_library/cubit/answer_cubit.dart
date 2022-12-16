import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionCubit {
  static Future addQuestion({
    required String question,
    required List<String> answers,
    required int answerInIndex,
    required String department,
    required String subject,
    required double fontSizeOfQuestion,
    required double fontSizeOfAnswers,
  }) async {
    //emit(AddQuestionLoadingState());

    await FirebaseFirestore.instance
        .collection('question')
        .doc('question')
        .collection(department)
        .doc(subject)
        .collection(subject)
        .doc()
        .set({
      'question': question,
      'answers': answers,
      'answerInIndex': answerInIndex,
      'forTest': false,
      'fontSizeOfQuestion': fontSizeOfQuestion,
      'fontSizeOfAnswers': fontSizeOfAnswers
    });
  }

  static Stream getAllData({
    required String department,
    required String subject,
  }) {
    //emit(GetAllQuestionSuccessState());
    return FirebaseFirestore.instance
        .collection('question')
        .doc('question')
        .collection(department)
        .doc(subject)
        .collection(subject)
        .where('forTest', isNotEqualTo: true)
        .snapshots();
  }

  static Future updateQuestion({
    required String? question,
    required List<String?> answers,
    required int? answerInIndex,
    required String department,
    required String docId,
    required String subject,
    required double? fontSizeOfQuestion,
    required double? fontSizeOfAnswers,
  }) {
    return FirebaseFirestore.instance
        .collection('question')
        .doc('question')
        .collection(department)
        .doc(subject)
        .collection(subject)
        .doc(docId)
        .set({
      'question': question,
      'answers': answers,
      'answerInIndex': answerInIndex,
      'forTest': false,
      'fontSizeOfQuestion': fontSizeOfQuestion,
      'fontSizeOfAnswers': fontSizeOfAnswers
    });
  }

  static Future deleteQuestion({
    required String department,
    required String docId,
    required String subject,
  }) {
    return FirebaseFirestore.instance
        .collection('question')
        .doc('question')
        .collection(department)
        .doc(subject)
        .collection(subject)
        .doc(docId)
        .delete();
  }
}
