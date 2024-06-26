abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetEmailSent extends ResetPasswordState {}

class ResetEmailError extends ResetPasswordState {
  final String error;

  ResetEmailError({required this.error});
}
