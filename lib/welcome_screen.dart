import 'package:flutter/material.dart';
import 'package:q4k/constants.dart';
import 'package:q4k/screens/sign_in/sign_in.dart';

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
            const Spacer(),
            Center(
              child: Image.asset("assets/images/dark logo.png"),
            ),
            const Spacer(),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
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
