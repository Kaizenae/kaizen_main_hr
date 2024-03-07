abstract class ForgetPasswordStates {}

class ForgetPasswordInitState extends ForgetPasswordStates {}

class CreateOtpState extends ForgetPasswordStates {}

class SendOtpLoadingState extends ForgetPasswordStates {}

class SendOtpSuccessState extends ForgetPasswordStates {}

class SendOtpErrorState extends ForgetPasswordStates {
  final String message;
  SendOtpErrorState({
    required this.message,
  });
}
