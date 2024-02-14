import 'dart:io';
import 'package:Attendace/core/local/cache_helper.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/features/login/data/models/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> baseKey = GlobalKey();
  TextEditingController baseUrlController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  cacheBaseUrl() async {
    // emit(CacheUrlStateLoading());
    // await CacheHelper.put(
    //     key: AppStrings.baseUrl, value: baseUrlController.text.trim());
    // EndPoints.baseUrl;
    //
    // print(    CacheHelper.get(key: AppStrings.baseUrl));
    // emit(CacheUrlStateSuccess());
  }

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

  getUniqueDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      uniqueDeviceId =
          '${iosDeviceInfo.systemName}:${iosDeviceInfo.identifierForVendor}';
      // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;

      uniqueDeviceId =
          '${androidDeviceInfo.model}:${androidDeviceInfo.id}'; // unique ID on Android
    }
  }
}
