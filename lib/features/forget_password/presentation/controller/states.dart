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

class GetUserIdLoadingState extends ForgetPasswordStates {}

class GetUserIdSuccessState extends ForgetPasswordStates {
  final String message;
  final int userID;
  GetUserIdSuccessState({
    required this.message,
    required this.userID,
  });
}

class GetUserIdErrorState extends ForgetPasswordStates {
  final String message;
  GetUserIdErrorState({required this.message});
}

class ChangePasswordLoadingState extends ForgetPasswordStates {}

class ChangePasswordSuccessState extends ForgetPasswordStates {
  final String message;
  ChangePasswordSuccessState({required this.message});
}

class ChangePasswordErrorState extends ForgetPasswordStates {
  final String message;
  ChangePasswordErrorState({required this.message});
}

class ChangePasswordVisibilityState extends ForgetPasswordStates {}
