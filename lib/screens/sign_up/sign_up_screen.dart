import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/styles/size_config.dart';
import 'components/body.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String routeName ='/sign_up';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context)=>Q4kRegisterCubit(),
      child: BlocConsumer<Q4kRegisterCubit,Q4kRegisterStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Sign Up"),
            ),
            body:const Body(),
          );
        },
      ),
    );
  }
}
