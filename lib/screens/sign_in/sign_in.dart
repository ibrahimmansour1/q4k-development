import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:q4k/main_screen.dart';
import '../../shared/local/cache_helper.dart';
import '../../shared/styles/size_config.dart';
import 'components/body.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  static String routeName = "/sign_in";

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
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId
            ).then((value) {
             Navigator.push(context, MaterialPageRoute(builder: (context){
               return const MainScreen();
             }));
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(centerTitle: true, title: const Text("Sign In")),
            body: Body(
              formKey: _formKey,
              emailController: emailController,
              passwordController: passwordController,
              state: state,
            ),
          );
        },
      ),
    );
  }
}
