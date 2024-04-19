// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../domain/entities/myRequests_entity.dart';
import '../../domain/usecases/myRequests_usecase.dart';
import 'myRequests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  final MyRequestsUsecase myRequestsUsecase;
  final MyRequestsPendingUsecase myRequestsPendingUsecase;

  MyRequestsCubit(
      {required this.myRequestsUsecase, required this.myRequestsPendingUsecase})
      : super(MyRequestsInitial());

  static MyRequestsCubit get(context) => BlocProvider.of(context);
  dynamic userId;
  Future<void> getMyRequestsFun() async {
    emit(GetMyRequestsLoading());
    Either<Failure, MyRequestsEntity> response = await myRequestsUsecase(
        EmployeeParams(
            userId: AppConstants.token, companyId: AppConstants.companyId));

    emit(response.fold((failure) {
      userId = null;

      return GetMyRequestsError(message: failure.message);
    }, (myRequestsEntity) {
      userId = null;

      return GetMyRequestsSuccess(myRequestsEntity: myRequestsEntity);
    }));
  }

  Future<void> getEmployeeRequestsFun() async {
    emit(GetEmployeeRequestsLoading());
    Either<Failure, MyRequestsEntity> response = await myRequestsUsecase(
        EmployeeParams(userId: userId, companyId: AppConstants.companyId));

    emit(response.fold((failure) {
      return GetEmployeeRequestsError(message: failure.message);
    }, (myRequestsEntity) {
      return GetEmployeeRequestsSuccess(myRequestsEntity: myRequestsEntity);
    }));
  }

  Future<void> getMyRequestsPendingFun() async {
    emit(GetMyRequestsPendingLoading());
    Either<Failure, MyRequestsEntity> response = await myRequestsPendingUsecase(
        EmployeeParams(
            userId: userId ?? AppConstants.token,
            companyId: AppConstants.companyId));

    emit(response.fold((failure) {
      userId = null;
      return GetMyRequestsPendingError(message: failure.message);
    }, (myRequestsEntity) {
      userId = null;

      return GetMyRequestsPendingSuccess(myRequestsEntity: myRequestsEntity);
    }));
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
