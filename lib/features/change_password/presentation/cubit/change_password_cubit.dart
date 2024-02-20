import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../domain/entities/change_password_entity.dart';
import '../../domain/usecases/change_password_usecase.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  final EditChangePasswordUsecase editChangePasswordUsecase;

  ChangePasswordCubit({required this.editChangePasswordUsecase})
      : super(InitChangePasswordState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  changePasswordFun() async {
    emit(ChangePasswordLoadingState());
    Either<Failure, ChangePasswordEntity> response =
        await editChangePasswordUsecase(ChangePasswordParams(
      userId: AppConstants.token,
      oldPassword: oldPasswordController.text,
      newPassword: newPasswordController.text,
    ));

    emit(response.fold(
        (failure) => ChangePasswordErrorState(message: failure.message),
        (changePasswordEntity) => ChangePasswordSuccessState(
            changePasswordEntity: changePasswordEntity)));
  }

  String suffix = IconsAssets.hiddenIcon;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? IconsAssets.hiddenIcon : IconsAssets.hidden2Icon;
    emit(ChangePasswordVisibilityState());
  }

  String suffixConfirm = IconsAssets.hiddenIcon;
  bool isPasswordConfirm = true;

  void changePasswordConfirmVisibility() {
    isPasswordConfirm = !isPasswordConfirm;
    suffixConfirm =
        isPasswordConfirm ? IconsAssets.hiddenIcon : IconsAssets.hidden2Icon;
    emit(ChangeEyeConfirmState());
  }
}
