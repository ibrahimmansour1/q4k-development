import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:q4k/constants.dart';
import 'package:q4k/screens/sign_in/sign_in.dart';

import 'main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Image.asset("assets/images/dark-logo.jpg"),
            ),
            const Spacer(),
            Text('All you want is here',
                style: GoogleFonts.cookie(
                    fontSize: 40,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    color: primaryColor.withOpacity(0.5))),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  }
                },
                color: primaryColor,
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: (18), color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
