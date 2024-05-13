import 'package:Attendace/core/local/cache_helper.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/features/login/data/models/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginUsecase loginUsecase;

  LoginCubit({required this.loginUsecase}) : super(InitLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController baseUrlController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginFun() async {
    emit(LoginLoadingState());
    await CacheHelper.put(
        key: AppStrings.baseUrl, value: baseUrlController.text);
    Either<Failure, LoginEntity> response = await loginUsecase(LoginParams(
        email: emailController.text,
        password: passwordController.text,
        uniqueDeviceId: uniqueDeviceId));

    emit(response.fold((failure) => LoginErrorState(message: failure.message),
        (loginEntity) => LoginSuccessState(loginEntity: loginEntity)));
  }

  int loginStatus = 0;

  String suffix = IconsAssets.hiddenIcon;
  bool isPassword = true;
  LoginModel? loginModel;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? IconsAssets.hiddenIcon : IconsAssets.hidden2Icon;
    emit(LoginChangePasswordVisibilityState());
  }

  String uniqueDeviceId = '';
  void changePassword({required String userId, required String newPassword}) {
    emit(ChangePasswordLoadingState());
    Dio().post(EndPoints.forgetPasswordPath, data: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": userId,
        "phone": "",
        "new_password": newPassword,
      }
    }).then((value) {
      emit(
          ChangePasswordSuccessState(message: value.data["result"]["message"]));
    }).catchError((error) {
      emit(ChangePasswordErrorState(
          message: AppStrings.someThingWentWrongTryAgainLater));
    });
  }
}
