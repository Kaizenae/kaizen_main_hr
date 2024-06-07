import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/local/cache_helper.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/constants_manager.dart';
import '../../../../../core/utils/strings_manager.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/usecases/employee_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final EmployeeUsecase employeeUsecase;
  final EmployeessUsecase employeesUsecase;

  ProfileCubit({
    required this.employeeUsecase,
    required this.employeesUsecase,
  }) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  int? userId;

  Future<void> getEmployeeFun() async {
    emit(GetEmployeeLoading());
    Either<Failure, EmployeeEntity> response = await employeeUsecase(
        EmployeeParams(userId: userId ?? AppConstants.token));

    emit(response.fold((failure) {
      userId = null;
      return GetEmployeeError(message: failure.message);
    }, (employeeEntity) {
      userId = null;
      return GetEmployeeSuccess(employeeEntity: employeeEntity);
    }));
  }

  Future<void> getEmployeesFun() async {
    emit(GetEmployeesLoading());
    Either<Failure, EmployeeEntity> response =
        await employeesUsecase(const EmployeeParams(userId: ""));

    emit(response.fold((failure) {
      return GetEmployeesError(message: failure.message);
    }, (employeeEntity) {
      AppConstants.admins = [];
      for (var element in employeeEntity.resultEntity.response) {
        if (element.isAdmin) {
          AppConstants.admins.add(element.noId);
        }
      }
      return GetEmployeesSuccess(employeeEntity: employeeEntity);
    }));
  }

  Future<void> logout(BuildContext context) async {
    await CacheHelper.removeData(key: AppStrings.token);
    await CacheHelper.removeData(key: AppStrings.cachedLogin);
    await CacheHelper.removeData(key: AppStrings.cachedRegister);
    await CacheHelper.removeData(key: AppStrings.admin);
    await CacheHelper.removeData(key: AppStrings.company);
    await CacheHelper.removeData(key: AppConstants.checkInOrCheckOut);

    AppConstants.token = CacheHelper.get(key: AppStrings.token) ?? 0;
    AppConstants.admin = CacheHelper.get(key: AppStrings.admin) ?? false;
    AppConstants.companyId = CacheHelper.get(key: AppStrings.company) ?? 0;

    emit(LogoutState());
  }

  List<String> profileNames = [
    AppStrings.changePassword,
    AppStrings.notifications,
    AppStrings.settings,
  ];

  List<String> profileIconName = [
    IconsAssets.lockIcon,
    IconsAssets.notificationIcon,
    IconsAssets.settingIcon,
  ];
  formatDate({required String format, required String dateTime}) {
    var date = DateFormat(format);
    var formatDate = date.format(DateTime.parse(dateTime));
    return formatDate;
  }
}
