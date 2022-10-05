
abstract class Q4kLoginStates{}

class Q4kLoginInitialState extends Q4kLoginStates{}

class Q4kLoginLoadingState extends Q4kLoginStates{}

class Q4kLoginSuccessState extends Q4kLoginStates{
  final String uId;
  Q4kLoginSuccessState(this.uId);
}

class Q4kLoginErrorState extends Q4kLoginStates{
  final String error;

  Q4kLoginErrorState(this.error);
}
