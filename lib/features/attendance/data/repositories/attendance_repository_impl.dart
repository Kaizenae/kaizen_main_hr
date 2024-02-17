import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/attendace_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final NetworkInfo networkInfo;
  final AttendanceRemoteDataSource attendanceRemoteDataSource;

  AttendanceRepositoryImpl(
      {required this.networkInfo, required this.attendanceRemoteDataSource});

  @override
  Future<Either<Failure, AttendanceEntity>> attendance(attendanceParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAttendance = await attendanceRemoteDataSource.attendance(
          userId: attendanceParams.userId,
        );
        if (remoteAttendance.resultEntity.status == 200) {
          // await  AttendanceLocalDataSource.cacheAttendance(remoteAttendance);
          return Right(remoteAttendance);
        } else {
          return Left(Failure(400, 'Get Attendance Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
