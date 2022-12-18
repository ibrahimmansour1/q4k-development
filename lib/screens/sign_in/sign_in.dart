import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:q4k/main_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/UserProfile.dart';
import '../../shared/local/cache_helper.dart';
import '../../shared/styles/size_config.dart';
import 'components/body.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  static String routeName = "/sign_in";
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (BuildContext context) => Q4kLoginCubit(),
      child: BlocConsumer<Q4kLoginCubit, Q4kLoginStates>(
        listener: (context, state) {
          if (state is Q4kLoginErrorState) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is Q4kLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const MainScreen();
              }));
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(centerTitle: true, title: const Text("Sign In")),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Body(
                    formKey: _formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                    state: state,
                  ),
                  googleButton(context: context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    UserCredential authResult =
        await _auth.signInWithCredential(authCredential);
    User? user = authResult.user;
    print('user email = ${user!.email}');

    if (authResult.additionalUserInfo!.isNewUser) {
      userProfile accountUser = userProfile(
          userId: user.uid,
          name: user.displayName.toString(),
          email: user.email.toString(),
          department: "none",
          image: "image",
          activeTime: FieldValue.serverTimestamp(),
          level: 0.0);
      _firestore.collection('user').doc(user.uid).set(accountUser.toMap());
    }

    Future<void> signOut() async {
      await _googleSignIn.signOut();
    }
  }

  Widget googleButton(
      {void Function()? onPressed, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: InkWell(
        onTap: () {
          signInWithGoogle();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        },
        child: Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: const Color(0xff4286F5),
                        width: 2,
                      )),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/googleLogo.png",
                    width: 30,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff4286F5),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Log in with Google',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
