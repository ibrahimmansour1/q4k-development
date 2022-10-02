// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'dart:async' show Future;
// import 'package:flutter/services.dart' show rootBundle;

// Future<String> loadAsset() async {
//   return await rootBundle.loadString('assets/hadith.txt');
// }

// class HadithScreen extends StatefulWidget {
//   const HadithScreen({Key? key}) : super(key: key);

//   @override
//   State<HadithScreen> createState() => _HadithScreenState();
// }

// class _HadithScreenState extends State<HadithScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: IconButton(
//           onPressed: () {
//          showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text("Show Alert Dialog Box"),
//             content: const Text("You have raised a Alert Dialog Box"),
//             actions: <Widget>[
//               MaterialButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop();
//                 },
//                 child: const Text("Ok"),
//               ),
//             ],
//           ),
//         );
//       },
//           icon: const Icon(Icons.add)),
//     );
//   }
// }
