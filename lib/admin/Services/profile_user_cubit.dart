import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/admin/Models/user_model.dart';
import 'package:healthcare/admin/Services/profile_user_state.dart';
import 'package:healthcare/share/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

//part 'profile_state.dart';

class ProfileUserCubit extends Cubit<ProfileUserState> {
  ProfileUserCubit() : super(ProfileUserInitialState());

  UserModel? userModel;
  Future<void> getUsersData() async {
    emit(GetUsersDataLoadingState());
    try {
      Response response = await http.get(
        Uri.parse("http://3.129.148.71:3000/api/v1/getUserData"),
        headers: {
          'authorization': adminToken!,
          'id': userId!,
        },
      );
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        userModel = UserModel.fromJson(data: responseData['user']);
        print("response is : $responseData");
        emit(GetUsersDataSuccessState());
      } else {
        emit(FailedToGetUsersDataState(error: responseData['message']));
      }
    } catch (e) {
      emit(FailedToGetUsersDataState(error: e.toString()));
    }
  }

  void clearProfileData() {
    userModel = null;
  }
}
