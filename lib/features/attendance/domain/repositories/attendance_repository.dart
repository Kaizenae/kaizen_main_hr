import 'package:Attendace/features/attendance/domain/entities/attendace_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, AttendanceEntity>> attendance(EmployeeParams params);
}
