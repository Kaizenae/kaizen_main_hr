import 'package:Attendace/core/error/failure.dart';
import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/features/create_loan/domain/entities/create_loan_entity.dart';
import 'package:Attendace/features/create_loan/domain/entities/get_currency_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CreateLoanRepository {
  Future<Either<Failure, CreateLoanEntity>> createLoan(
      CreateLoanParams createLoanParams);
  Future<Either<Failure, GetCurrencyEntity>> getCurrency(NoParams noParams);
}
