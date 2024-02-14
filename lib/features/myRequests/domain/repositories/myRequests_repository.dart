// ignore_for_file: file_names

import '../../domain/entities/myRequests_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

abstract class MyRequestsRepository {
  Future<Either<Failure, MyRequestsEntity>> myRequests(EmployeeParams params);
  Future<Either<Failure, MyRequestsEntity>> myRequestsPending(
      EmployeeParams params);
}
