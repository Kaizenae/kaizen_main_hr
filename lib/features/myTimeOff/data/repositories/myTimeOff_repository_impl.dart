// ignore_for_file: file_names

import 'package:Attendace/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/myTimeOff_entity.dart';
import '../../domain/repositories/myTimeOff_repository.dart';
import '../datasources/myTimeOff_remote_datasource.dart';

class MyTimeOffRepositoryImpl implements MyTimeOffRepository {
  final NetworkInfo networkInfo;
  final MyTimeOffRemoteDataSource myTimeOffRemoteDataSource;

  MyTimeOffRepositoryImpl(
      {required this.networkInfo, required this.myTimeOffRemoteDataSource});

  @override
  Future<Either<Failure, MyTimeOffEntity>> myTimeOff(myTimeOffParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAttendance = await myTimeOffRemoteDataSource.myTimeOff(
          userId: myTimeOffParams.userId,
        );
        if (remoteAttendance.resultEntity.status == 200) {
          // await MyTimeOffLocalDataSource.cacheAttendance(remoteAttendance);
          return Right(remoteAttendance);
        } else {
          return Left(Failure(400, 'GetMyTimeOff Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, MyTimeOffEntity>> allTimeOff(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAttendance = await myTimeOffRemoteDataSource.allTimeOff();
        if (remoteAttendance.resultEntity.status == 200) {
          // await MyTimeOffLocalDataSource.cacheAttendance(remoteAttendance);
          return Right(remoteAttendance);
        } else {
          return Left(Failure(400, 'GetMyTimeOff Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
