import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/features/create_loan/domain/entities/get_currency_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/create_loan_usecase.dart';
import 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final GetCurrencyUsecase getCurrencyUsecase;

  CurrencyCubit({required this.getCurrencyUsecase}) : super(CurrencyInitial());

  static CurrencyCubit get(context) => BlocProvider.of(context);

  Future<void> getCurrencyFun() async {
    emit(GetCurrencyLoading());
    Either<Failure, GetCurrencyEntity> response =
        await getCurrencyUsecase(NoParams());

    emit(response.fold((failure) {
      return GetCurrencyError(message: failure.message);
    }, (getCurrencyEntity) {
      return GetCurrencySuccess(getCurrencyEntity: getCurrencyEntity);
    }));
  }
}
