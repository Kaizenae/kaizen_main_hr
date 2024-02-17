import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/create_loan_entity.dart';
import '../../domain/usecases/create_loan_usecase.dart';
import 'create_loan_state.dart';

class CreateLoanCubit extends Cubit<CreateLoanState> {
  final CreateLoanUsecase createLoanUsecase;

  CreateLoanCubit({required this.createLoanUsecase})
      : super(CreateLoanInitial());

  static CreateLoanCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loanAmountController = TextEditingController();
  String checkType = '';
  int selectedValue = 0;

  Future<void> createLoanFun() async {
    emit(CreateLoanLoading());
    Either<Failure, CreateLoanEntity> response =
        await createLoanUsecase(CreateLoanParams(
      currencyId: selectedValue,
      loanAmount: double.parse(loanAmountController.text),
      userId: AppConstants.token,
    ));

    emit(response.fold((failure) {
      return CreateLoanError(message: failure.message);
    }, (createLoanEntity) {
      return CreateLoanSuccess(createLoanEntity: createLoanEntity);
    }));
  }

  getCurrency(String currency) {
    emit(CurrencyLoading());
    checkType = currency;
    emit(CurrencySuccess());
  }
}
