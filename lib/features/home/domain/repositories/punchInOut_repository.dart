// ignore_for_file: file_names

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/punchInOut_entity.dart';

abstract class PunchInOutRepository {
  Future<Either<Failure, PunchInOutEntity>> punchInOut(EmployeeParams params);
}
