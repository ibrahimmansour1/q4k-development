import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import 'states.dart';

class Q4kRegisterCubit extends Cubit<Q4kRegisterStates> {
  Q4kRegisterCubit() : super(Q4kRegisterInitialState());

  static Q4kRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(Q4kRegisterLoadingState());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCreate(
          name: name,
          email: email,
          uId: userCredential.user?.uid ?? "uid");

      emit(Q4kCreateUserSuccessState());
    } catch (error) {
      print(error.toString());
      emit(Q4kCreateUserErrorState(error.toString()));
    }
  }

  Future<void> userCreate({
    required String email,
    required String uId,
    required String name,
  }) async {
    UserModel model = UserModel(
      email: email,
      uId: uId,
      name: name,
      bio: "Write your bio here ...",
      cover: "assets/images/Video Place Here.png",
      image:
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
      isEmailVerified: false,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap());
  }

  Future<void> userUpdateData({
    required String name,
    required String phone,
    required String uId,
  }) async {
    UserModel model = UserModel(name: name, phone: phone);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap());
  }
}
