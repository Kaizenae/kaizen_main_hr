import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../domain/entities/edit_profile_entity.dart';
import '../../domain/usecases/edit_profile_usecase.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  final EditUserNameUsecase editProfileUsecase;
  final EditDepartmentUsecase editDepartmentUsecase;
  final EditNoIdUsecase editNoIdUsecase;

  EditProfileCubit(
      {required this.editProfileUsecase,
      required this.editDepartmentUsecase,
      required this.editNoIdUsecase})
      : super(InitEditProfileState());

  static EditProfileCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? noId = '';

  Future<void> editUserNameFun() async {
    emit(EditProfileLoadingState());
    Either<Failure, EditProfileEntity> response =
        await editProfileUsecase(EditProfileParams(
      userName: userNameController.text,
      userId: AppConstants.token,
    ));

    emit(response.fold(
        (failure) => EditProfileErrorState(message: failure.message),
        (editProfileEntity) =>
            EditProfileSuccessState(editProfileEntity: editProfileEntity)));
  }

  Future<void> editDepartmentFun() async {
    emit(EditProfileLoadingState());
    Either<Failure, EditProfileEntity> response = await editDepartmentUsecase(
        EditProfileParams(
            phoneNumber: phoneNumberController.text,
            userName: AppConstants.employeeName,
            userId: AppConstants.token));

    emit(response.fold(
        (failure) => EditProfileErrorState(message: failure.message),
        (editProfileEntity) =>
            EditProfileSuccessState(editProfileEntity: editProfileEntity)));
  }

  Future<void> editNoIdFun() async {
    emit(EditProfileLoadingState());
    Either<Failure, EditProfileEntity> response =
        await editNoIdUsecase(EditProfileParams(
      noId: noId,
      userId: AppConstants.token,
    ));

    emit(response.fold(
        (failure) => EditProfileErrorState(message: failure.message),
        (editProfileEntity) =>
            EditProfileSuccessState(editProfileEntity: editProfileEntity)));
  }

  List<String> profileNames = [
    AppStrings.changeUserName,
    AppStrings.changePhoneNumber,
  ];
  List<String> screenNames = [
    Routes.editUserNameRoute,
    Routes.editPhoneNumberRoute,
  ];
  List<String> profileIconName = [
    IconsAssets.personIcon,
    IconsAssets.phoneIcon,
  ];
}
