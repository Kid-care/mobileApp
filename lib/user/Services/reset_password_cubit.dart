import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthcare/user/Services/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> sendResetEmail(String email) async {
    final url = 'http://3.129.148.71:3000/password/forgot-password';
    final dio = Dio();
    try {
      final response = await dio.post(url, data: {'email': email});
      if (response.statusCode == 200) {
        emit(ResetEmailSent());
      } else {
        emit(ResetEmailError(
            error:
                'Failed to send reset email. Status Code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ResetEmailError(error: 'Failed to send reset email.'));
    }
  }
}
