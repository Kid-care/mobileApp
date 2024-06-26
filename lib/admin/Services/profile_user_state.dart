abstract class ProfileUserState {}

class ProfileUserInitialState extends ProfileUserState {}

class GetUsersDataSuccessState extends ProfileUserState {}

class GetUsersDataLoadingState extends ProfileUserState {}

class FailedToGetUsersDataState extends ProfileUserState {
  String error;
  FailedToGetUsersDataState({required this.error});
}
