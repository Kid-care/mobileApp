abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoginLoadingState extends UserStates {}

class UserLoginSuccessState extends UserStates {}

class UserFailedToLoginState extends UserStates {
  final String message;
  UserFailedToLoginState({required this.message});
}
