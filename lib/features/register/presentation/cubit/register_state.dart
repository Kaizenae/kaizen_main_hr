import '../../domain/entities/register_entity.dart';

abstract class RegisterStates {}

class InitRegisterState extends RegisterStates {}

class CacheUrlStateLoading extends RegisterStates {}

class CacheUrlStateSuccess extends RegisterStates {}

class CheckTypeStateLoading extends RegisterStates {}

class CheckTypeStateSuccess extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterEntity registerEntity;

  RegisterSuccessState({required this.registerEntity});
}

class RegisterErrorState extends RegisterStates {
  final String message;

  RegisterErrorState({required this.message});
}

class LogOutState extends RegisterStates {}

class ChangeEyeState extends RegisterStates {}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class ChangeregisterState extends RegisterStates {}

class ChangeForgetPasswordState extends RegisterStates {}

class ChangeEmailValidateState extends RegisterStates {}

class ChangePasswordValidateState extends RegisterStates {}

class ChangeNameOfCompanyState extends RegisterStates {}

class GetCompaniesLoadingState extends RegisterStates {}

class GetCompaniesSuccessState extends RegisterStates {}

class GetCompaniesErrorState extends RegisterStates {}

class ChangeCompaniesState extends RegisterStates {}
