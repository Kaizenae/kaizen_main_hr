import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/usecases/register_usecase.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterUsecase registerUsecase;

  RegisterCubit({required this.registerUsecase}) : super(InitRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController baseUrlController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  int companyId = 1;
  String companyName = '';
  String checkType = '';
  String selectedValue = '';

  cacheBseUrl() async {
    // emit(CacheUrlStateLoading());
    //
    // EndPoints.baseUrl;
    // print(    CacheHelper.get(key: AppStrings.baseUrl));
    //
    // emit(CacheUrlStateSuccess());
  }

  Future<void> registerFun() async {
    emit(RegisterLoadingState());

    Either<Failure, RegisterEntity> response = await registerUsecase(
        RegisterParams(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            phoneNumber: phoneNumberController.text,
            companyId: companyId,
            uniqueDeviceId: uniqueDeviceId));

    emit(response.fold(
        (failure) => RegisterErrorState(message: failure.message),
        (registerEntity) =>
            RegisterSuccessState(registerEntity: registerEntity)));
  }

  int registerStatus = 0;

  String suffix = IconsAssets.hiddenIcon;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? IconsAssets.hiddenIcon : IconsAssets.hidden2Icon;
    emit(RegisterChangePasswordVisibilityState());
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
