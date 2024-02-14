// ignore_for_file: file_names

import '../../domain/entities/myLoans_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

abstract class MyLoansRepository {
  Future<Either<Failure, MyLoansEntity>> myLoans(EmployeeParams params);
  Future<Either<Failure, MyLoansEntity>> cancelMyLoans(UpdateLoanParams params);
}
