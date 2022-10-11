import 'package:flutter/material.dart';
import 'package:q4k/main_screen.dart';
import '../../../constants.dart';
import '../../../shared/components/custom_suffix_icon.dart';
import '../../../shared/components/default_button.dart';
import '../../../shared/styles/size_config.dart';
import '../cubit/cubit.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? emailController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

  TextEditingController? confirmPasswordController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  // TextEditingController phoneController = TextEditingController();
  bool passwordVisible = true;
  bool passwordVisible1 = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          buildLastNameField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmFormField(),
          // buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                Q4kRegisterCubit.get(context).userRegister(
                    email: emailController!.text,
                    password: passwordController!.text,
                    //phone: phoneController.text,
                    name: firstNameController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MainScreen();
                }));
              }
            },
          ),
        ],
      ),
    );
  }

  // TextFormField buildPhoneNumberFormField() {
  TextFormField buildNameField() {
    return TextFormField(
      controller: firstNameController,
      validator: (value) {
        if (value!.isEmpty) {
          return kNameNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        labelText: "Name",
        hintText: "Enter your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildLastNameField() {
    return TextFormField(
      controller: lastNameController,
      validator: (value) {
        if (value!.isEmpty) {
          return kNameNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        labelText: "Last Name",
        hintText: "Enter Last your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildConfirmFormField() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: passwordVisible,
      onTap: () {
        setState(() {
          passwordVisible != passwordVisible;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (confirmPasswordController!.text !=
            passwordController!.text) {
          return kMatchPassError;
        } else if (value.contains(" ")) {
          return "Don't Enter Spaces";
        }
        return null;
      },
      decoration: InputDecoration(
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          border: outlineInputBorder(),
          labelText: "Confirm Password",
          hintText: "Confirm your Password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: passwordVisible == true
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
                  passwordVisible = !passwordVisible;
                });
              },
            ),
          )),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: passwordVisible1,
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 6) {
          return kShortPassError;
        } else if (value.contains(" ")) {
          return "Don't Enter Spaces";
        }
        return null;
      },
      decoration: InputDecoration(
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          border: outlineInputBorder(),
          labelText: "Password",
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: passwordVisible1 == true
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
                  passwordVisible1 = !passwordVisible1;
                });
              },
            ),
          )),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
