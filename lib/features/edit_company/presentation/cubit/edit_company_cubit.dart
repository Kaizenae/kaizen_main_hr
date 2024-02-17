import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../domain/entities/edit_company_entity.dart';
import '../../domain/usecases/edit_company_usecase.dart';
import 'edit_company_state.dart';

class EditCompanyCubit extends Cubit<EditCompanyStates> {
  final EditLocationUsecase editLocationUsecase;

  EditCompanyCubit({
    required this.editLocationUsecase,
  }) : super(InitEditCompanyState());

  static EditCompanyCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  int companyId = 0;

  Future<void> editLocationFun() async {
    emit(EditCompanyLoadingState());
    Either<Failure, EditCompanyEntity> response =
        await editLocationUsecase(EditCompanyParams(
      companyId: AppConstants.companyId,
      lat: latController.text,
      long: longController.text,
    ));

    emit(response.fold(
        (failure) => EditCompanyErrorState(message: failure.message),
        (editProfileEntity) =>
            EditCompanySuccessState(editCompanyEntity: editProfileEntity)));
  }

  List<String> profileNames = [
    AppStrings.changeCompanyLocation,
  ];
  List<String> screenNames = [
    Routes.editCompanyLocationRoute,
  ];
  List<String> profileIconName = [
    IconsAssets.locationIcon,
  ];
}
