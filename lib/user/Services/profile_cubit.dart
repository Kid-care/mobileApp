import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/admin/Models/user_model.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/share/local_network.dart';
import 'package:healthcare/user/Services/profile_states.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

//part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  UserModel? userModel;

  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    try {
      String? userToken = await CacheNetwork.getCacheData(key: "token");
      Response response = await http.get(
        Uri.parse("http://3.129.148.71:3000/api/v1/getprofile"),
        headers: {
          'authorization': userToken!,
        },
      );
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        userModel = UserModel.fromJson(data: responseData['user']);
        print("response is : $responseData");
        emit(GetUserDataSuccessState());
      } else {
        emit(FailedToGetUserDataState(error: responseData['message']));
      }
    } catch (e) {
      emit(FailedToGetUserDataState(error: e.toString()));
    }
  }

  void clearProfileData() {
    userModel = null;
  }

  void updateUserData({
    required String name,
    required String phone,
    required String nationalId,
    required String fatherName,
    required String motherName,
    required String date,
    required String bloodType,
  }) async {
    emit(UpdateUserDataLoadingState());
    try {
      Response response = await http.post(
          Uri.parse("http://3.129.148.71:3000/api/v1/updateprofile"),
          headers: {
            'authorization': userToken!,
          },
          body: {
            'userName': name,
            'fatherName': fatherName,
            "motherName": motherName,
            'phoneNumber': phone,
            'NationalID': nationalId,
            'birthDate': date,
            'bloodType': bloodType,
          });
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        await getUserData();
        emit(UpdateUserDataSuccessState());
      } else {
        emit(UpdateUserDataWithFailureState(responseBody['message']));
      }
    } catch (e) {
      emit(UpdateUserDataWithFailureState(e.toString()));
    }
  }
}
