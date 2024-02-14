import 'package:Attendace/core/error/failure.dart';
import 'package:Attendace/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/create_loan_entity.dart';
import '../entities/get_currency_entity.dart';
import '../repositories/create_loan_repository.dart';

class CreateLoanUsecase implements UseCase<CreateLoanEntity, CreateLoanParams> {
  final CreateLoanRepository createLoanRepository;

  CreateLoanUsecase(this.createLoanRepository);

  @override
  Future<Either<Failure, CreateLoanEntity>> call(CreateLoanParams params) =>
      createLoanRepository.createLoan(params);
}

class GetCurrencyUsecase implements UseCase<GetCurrencyEntity, NoParams> {
  final CreateLoanRepository createLoanRepository;

  GetCurrencyUsecase(this.createLoanRepository);

  @override
  Future<Either<Failure, GetCurrencyEntity>> call(NoParams params) =>
      createLoanRepository.getCurrency(params);
}
