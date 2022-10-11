import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:q4k/main_screen.dart';
import '../../../constants.dart';
import '../../../shared/components/custom_suffix_icon.dart';
import '../../../shared/components/default_button.dart';
import '../../../shared/components/no_account_text.dart';
import '../../../shared/components/social_card.dart';
import '../../../shared/styles/size_config.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
    required this.state,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final Q4kLoginStates? state;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              Text(
                "Welcome back",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Sign in with your email and password ",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.08,
              ),
              Form(
                key: widget._formKey,
                child: Column(
                  children: [
                    buildEmailTextFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    buildPassTextFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          activeColor: kPrimaryColor,
                          onChanged: (value) {},
                        ),
                        const Text("Remember me"),
                        // const Spacer(),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: const Text(
                        //     "Forgot Password",
                        //     style:
                        //         TextStyle(decoration: TextDecoration.underline),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    ConditionalBuilder(
                      condition: widget.state is! Q4kLoginLoadingState,
                      builder: (context) => DefaultButton(
                          text: "Continue",
                          press: () {
                            if (widget._formKey.currentState!.validate()) {
                              Q4kLoginCubit.get(context).userLogin(
                                  email: widget.emailController!.text,
                                  password: widget.passwordController!.text);
                            } else if (FirebaseAuth.instance.currentUser !=
                                null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                            }
                          }),
                      fallback: (context) => const CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              const NoAccountText(),
            ],
          ),
        ),
      ),
    ));
  }

  bool visiblePassword = true;

  TextFormField buildPassTextFormField() {
    return TextFormField(
      obscureText: visiblePassword,
      controller: widget.passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kPassNullError;
        } else if (value.length < 7) {
          return kShortPassError;
        }
        return null;
      },
      decoration: InputDecoration(
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          border: outlineInputBorder(),
          labelText: "Password",
          hintText: "Enter your Password",
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: visiblePassword == true
                  ? Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.grey,
                    )
                  : Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
              onPressed: () {
                setState(() {
                  visiblePassword = !visiblePassword;
                });
              },
            ),
          )),
    );
  }

  TextFormField buildEmailTextFormField() {
    return TextFormField(
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
      decoration: InputDecoration(
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          border: outlineInputBorder(),
          labelText: "Email",
          hintText: "Enter your email",
          suffixIcon: const CustomSuffixIcon(svgIcon: 'assets/icons/Mail.svg')),
    );
  }
}
