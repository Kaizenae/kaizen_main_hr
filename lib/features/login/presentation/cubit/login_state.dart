import '../../domain/entities/login_entity.dart';

abstract class LoginStates {}

class InitLoginState extends LoginStates {}

class CacheUrlStateLoading extends LoginStates {}

class CacheUrlStateSuccess extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginEntity loginEntity;

  LoginSuccessState({required this.loginEntity});
}

class LoginErrorState extends LoginStates {
  final String message;

  LoginErrorState({required this.message});
}

class LogOutState extends LoginStates {}

class ChangeEyeState extends LoginStates {}

class LoginChangePasswordVisibilityState extends LoginStates {}

class ChangeLoginState extends LoginStates {}

class ChangeForgetPasswordState extends LoginStates {}

class ChangeEmailValidateState extends LoginStates {}

class ChangePasswordValidateState extends LoginStates {}

class ChangePasswordLoadingState extends LoginStates {}

class ChangePasswordSuccessState extends LoginStates {
  final String message;

  ChangePasswordSuccessState({required this.message});
}

class ChangePasswordErrorState extends LoginStates {
  final String message;

  ChangePasswordErrorState({required this.message});
}
