import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendace_entity.dart';
import '../repositories/attendance_repository.dart';

class AttendanceUsecase implements UseCase<AttendanceEntity, EmployeeParams> {
  final AttendanceRepository attendanceRepository;

  AttendanceUsecase(this.attendanceRepository);

  @override
  Future<Either<Failure, AttendanceEntity>> call(EmployeeParams params) =>
      attendanceRepository.attendance(params);
}
