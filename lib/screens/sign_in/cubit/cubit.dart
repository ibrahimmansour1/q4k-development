import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class Q4kLoginCubit extends Cubit<Q4kLoginStates> {
  Q4kLoginCubit() : super(Q4kLoginInitialState());

  static Q4kLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(Q4kLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(value.user!.email);
      emit(Q4kLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(Q4kLoginErrorState(error.toString()));
    });
  }
}
