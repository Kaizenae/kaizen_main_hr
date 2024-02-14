// ignore_for_file: file_names

import '../../domain/entities/myTimeOff_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

abstract class MyTimeOffRepository {
  Future<Either<Failure, MyTimeOffEntity>> myTimeOff(EmployeeParams params);
  Future<Either<Failure, MyTimeOffEntity>> allTimeOff(NoParams params);
}
