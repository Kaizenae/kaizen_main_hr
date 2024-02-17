// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../domain/entities/myLoans_entity.dart';
import '../../domain/usecases/myLoans_usecase.dart';
import 'myLoans_state.dart';

class MyLoansCubit extends Cubit<MyLoansState> {
  final MyLoansUsecase myLeavesUsecase;
  final CancelMyLoansUsecase cancelMyLoansUsecase;

  MyLoansCubit({
    required this.myLeavesUsecase,
    required this.cancelMyLoansUsecase,
  }) : super(MyLoansInitial());

  static MyLoansCubit get(context) => BlocProvider.of(context);
  dynamic userId;

  List<ResponseEntity> myLoansPending = [];
  List<ResponseEntity> myLoans = [];
  int loanID = 0;
  Future<void> getMyLoansFun() async {
    myLoansPending.clear();
    myLoans.clear();
    emit(GetMyLoansLoading());
    Either<Failure, MyLoansEntity> response = await myLeavesUsecase(
        EmployeeParams(userId: userId ?? AppConstants.token));

    emit(response.fold((failure) {
      return GetMyLoansError(message: failure.message);
    }, (myLoansEntity) {
      for (var element in myLoansEntity.resultEntity.response) {
        if (element.loanState != 'approve') {
          myLoansPending.add(element);
        } else {
          myLoans.add(element);
        }
      }
      return GetMyLoansSuccess(myLoansEntity: myLoansEntity);
    }));
  }

  Future<void> updatetMyLoansFun({required String state}) async {
    emit(CancelMyLoansLoading());
    Either<Failure, MyLoansEntity> response = await cancelMyLoansUsecase(
        UpdateLoanParams(
            userId: userId ?? AppConstants.token,
            loanId: loanID,
            state: state));

    emit(response.fold((failure) {
      return CancelMyLoansError(message: failure.message);
    }, (myLoansEntity) {
      getMyLoansFun();
      return CancelMyLoansSuccess(myLoansEntity: myLoansEntity);
    }));
  }
}
