import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/admin/Services/user_state.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/share/local_network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserLoginLoadingState());

  void search({required String email, required String id}) async {
    emit(UserLoginLoadingState());
    try {
      http.Response response = await http.post(
        Uri.parse('http://3.129.148.71:3000/api/v1/search/userSearch'),
        body: {'email': email, 'NationalID': id},
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        await CacheNetwork.insertToCache(
            key: "id", value: responseData['user']['_id']);
        userId = await CacheNetwork.getCacheData(key: "id");
        emit(UserLoginSuccessState());
      } else if (response.statusCode == 404) {
        var responseData = jsonDecode(response.body);
        emit(UserFailedToLoginState(message: responseData['message']));
      }
    } catch (e) {
      emit(UserFailedToLoginState(message: e.toString()));
    }
  }
}
