abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class GetUserDataSuccessState extends ProfileState {}

class GetUserDataLoadingState extends ProfileState {}

class FailedToGetUserDataState extends ProfileState {
  String error;
  FailedToGetUserDataState({required this.error});
}

class UpdateUserDataLoadingState extends ProfileState {}

class UpdateUserDataSuccessState extends ProfileState {}

class UpdateUserDataWithFailureState extends ProfileState {
  String error;

  UpdateUserDataWithFailureState(this.error);
}
