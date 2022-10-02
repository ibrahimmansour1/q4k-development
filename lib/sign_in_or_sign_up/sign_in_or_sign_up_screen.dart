import 'package:flutter/material.dart';
import 'package:q4k/screens/sign_in/sign_in.dart';

import '../shared/components/primary_button.dart';

class SignInOrSignUpScreen extends StatelessWidget {
  const SignInOrSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              Image.asset(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? "assets/images/dark logo.png"
                    : "assets/images/dark logo.png",
                height: 146,
              ),
              const Spacer(),
              PrimaryButton(
                  text: "Sign In",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  }),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                text: "Sign Up",
                press: () {
                  // Navigator.pushNamed(context, MainScreen.routeName);
                },
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
