import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:q4k/audio_player.dart';
import 'package:q4k/constants.dart';
import 'package:q4k/main_screen.dart';
import 'firebase_options.dart';
import 'hadith_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Intialize Firevase app
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  // @override
  // void initState() {
  //   super.initState();
  //     WidgetsBinding.instance.addPostFrameCallback((_) async {
  //       await showDialog(
  //         context: context,
  //         builder: (BuildContext context) => Center(
  //           child: AlertDialog(
  //             insetPadding: const EdgeInsets.all(20),
  //             contentPadding: const EdgeInsets.all(0),
  //             content: SizedBox(
  //               height: 200,
  //               width: MediaQuery.of(context).size.width,
  //               child: const Center(
  //                 child: Text("Alert dialog in app start up"),
  //               ),
  //             ),
  //             actions: const <Widget>[],
  //           ),
  //         ),
  //       );
  //     });
  //   }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // theme: lightThemeData(context),
      // darkTheme: darkThemeData(context),

      home: Scaffold(
        backgroundColor: lightColor,
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const MainScreen();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
