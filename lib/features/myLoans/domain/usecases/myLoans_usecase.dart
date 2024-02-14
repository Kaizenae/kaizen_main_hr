// ignore_for_file: file_names

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/myLoans_entity.dart';
import '../repositories/myLoans_repository.dart';

class MyLoansUsecase implements UseCase<MyLoansEntity, EmployeeParams> {
  final MyLoansRepository myLoansRepository;

  MyLoansUsecase(this.myLoansRepository);

  @override
  Future<Either<Failure, MyLoansEntity>> call(EmployeeParams params) =>
      myLoansRepository.myLoans(params);
}

class CancelMyLoansUsecase implements UseCase<MyLoansEntity, UpdateLoanParams> {
  final MyLoansRepository myLoansRepository;

  CancelMyLoansUsecase(this.myLoansRepository);

  @override
  Future<Either<Failure, MyLoansEntity>> call(UpdateLoanParams params) =>
      myLoansRepository.cancelMyLoans(params);
}
