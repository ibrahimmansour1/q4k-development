import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:q4k/audio_player.dart';
import 'package:q4k/constants.dart';
import 'package:q4k/main_screen.dart';
import 'package:q4k/question_library/notification_manager.dart';
import 'package:q4k/question_library/screens/home_screen.dart';
import 'package:q4k/screens/info_screen.dart';
import 'package:q4k/shared/local/cache_helper.dart';
import 'package:q4k/shared/styles/theme.dart';
import 'package:q4k/themes.dart';
import 'package:q4k/welcome_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CacheHelper.init();
  saveToken();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(MyApp()),
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      themeMode: ThemeMode.light,
      darkTheme: darkThemeData(context),
      theme: lightThemeData(context),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<FirebaseApp> _initializeFirebase() async {

    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    notificationManager(context);
    return Scaffold(
      backgroundColor: lightColor,
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const WelcomeScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
saveToken()async{
      bool? status = CacheHelper.getData(key: 'added FCM');
    if (status != true) {

       await FirebaseMessaging.instance.getToken().then((value) async{


         await FirebaseFirestore.instance
        .collection('/question/listOfNotificationToken/listOfNotificationToken').add({'token': value}).then((value) {
   CacheHelper.putBoolean(key: 'added FCM', value: true);
        });

      });

    }
}