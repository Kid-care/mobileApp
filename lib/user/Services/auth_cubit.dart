import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/share/local_network.dart';
import 'package:healthcare/user/Services/auth_states.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  String? currentAccountId;

  void register({
    required String name,
    required String phone,
    required String password,
    required String nationalId,
    required String fatherName,
    required String motherName,
    required String email,
    required String date,
    required String bloodType,
  }) async {
    emit(RegisterLoadingState());
    try {
      Response response = await http.post(
        Uri.parse('http://3.129.148.71:3000/api/v1/auth/register'),
        body: {
          'email': email,
          'userName': name,
          'password': password,
          'fatherName': fatherName,
          "motherName": motherName,
          'phoneNumber': phone,
          'NationalID': nationalId,
          'birthDate': date,
          'bloodType': bloodType,
        },
      );
      if (response.statusCode == 200) {
        emit(RegisterSuccessState());
      } else if (response.statusCode == 400) {
        var datas = jsonDecode(response.body);
        emit(FailedToRegisterState(message: datas['message']));
      }
    } catch (e) {
      debugPrint("Failed to Register , reason : $e");
      emit(FailedToRegisterState(message: e.toString()));
    }
  }

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      Response response = await http.post(
        Uri.parse('http://3.129.148.71:3000/api/v1/auth/loginAll'),
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        await CacheNetwork.insertToCache(key: "password", value: password);
        currentPassword = await CacheNetwork.getCacheData(key: "password");
        await saveToken(responseData['token']);

        String userRole = responseData['user']['roles'];

        if (userRole == "admin") {
          await CacheNetwork.insertToCache(
              key: "token", value: responseData['token']);
          adminToken = await CacheNetwork.getCacheData(key: "token");
          emit(AdminLoginSuccessState());
        } else if (userRole == "user") {
          await CacheNetwork.insertToCache(
              key: "token", value: responseData['token']);
          userToken = await CacheNetwork.getCacheData(key: "token");
          await CacheNetwork.insertToCache(
              key: "id", value: responseData['user']['_id']);
          userId = await CacheNetwork.getCacheData(key: "id");
          emit(LoginSuccessState());
        }
      } else if (response.statusCode == 400) {
        var responseData = jsonDecode(response.body);
        debugPrint("Failed to login, reason is : ${responseData['message']}");
        emit(FailedToLoginState(message: responseData['message']));
      }
    } catch (e) {
      emit(FailedToLoginState(message: e.toString()));
    }
  }
}
