
abstract class Q4kRegisterStates{}

class Q4kRegisterInitialState extends Q4kRegisterStates{}

class Q4kRegisterLoadingState extends Q4kRegisterStates{}

class Q4kRegisterSuccessState extends Q4kRegisterStates{

}

class Q4kRegisterErrorState extends Q4kRegisterStates{
  final String error;

  Q4kRegisterErrorState(this.error);
}

class Q4kCreateUserLoadingState extends Q4kRegisterStates{}

class Q4kCreateUserSuccessState extends Q4kRegisterStates{

}

class Q4kCreateUserErrorState extends Q4kRegisterStates{
  final String error;

  Q4kCreateUserErrorState(this.error);
}