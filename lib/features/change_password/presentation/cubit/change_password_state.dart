import '../../domain/entities/change_password_entity.dart';

abstract class ChangePasswordStates {}

class InitChangePasswordState extends ChangePasswordStates {}

class ChangePasswordVisibilityState extends ChangePasswordStates {}

class ChangeEyeConfirmState extends ChangePasswordStates {}

class ChangePasswordLoadingState extends ChangePasswordStates {}

class ChangePasswordSuccessState extends ChangePasswordStates {
  final ChangePasswordEntity changePasswordEntity;

  ChangePasswordSuccessState({required this.changePasswordEntity});
}

class ChangePasswordErrorState extends ChangePasswordStates {
  final String message;

  ChangePasswordErrorState({required this.message});
}
