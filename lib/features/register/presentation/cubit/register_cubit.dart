import 'package:Attendace/core/api/end_points.dart';
import 'package:Attendace/features/register/data/models/companies_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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

  TextEditingController baseUrlController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController employeeCode = TextEditingController();
  int companyId = 1;
  String companyName = "";
  String checkType = '';
  String selectedValue = '';

  Future<void> registerFun() async {
    emit(RegisterLoadingState());

    Either<Failure, RegisterEntity> response =
        await registerUsecase(RegisterParams(
      email: emailController.text.isNotEmpty
          ? emailController.text
          : phoneNumberController.text,
      password: passwordController.text,
      name: nameController.text,
      phoneNumber: phoneNumberController.text,
      companyId: companyId,
      uniqueDeviceId: uniqueDeviceId,
      employeeCode: employeeCode.text,
    ));

    emit(response.fold((failure) {
      return RegisterErrorState(message: failure.message);
    },
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

  CompaniesDataModel companiesDataModel = CompaniesDataModel();
  void getCompaniesData() {
    emit(GetCompaniesLoadingState());
    Dio().get(EndPoints.getCompaniesUrl, data: {
      "jsonrpc": "2.0",
      "params": {
        "company_id": "",
      }
    }).then((value) {
      companiesDataModel = CompaniesDataModel.fromJson(value.data);
      emit(GetCompaniesSuccessState());
    }).catchError((error) {
      emit(GetCompaniesErrorState());
    });
  }

  void changeCompany(ResponseModel model) {
    companyName = model.companyName!;
    companyId = model.companyId!;

    emit(ChangeCompaniesState());
  }
}
