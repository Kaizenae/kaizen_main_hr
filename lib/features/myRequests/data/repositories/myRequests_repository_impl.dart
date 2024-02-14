// ignore_for_file: file_names

import 'package:Attendace/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/myRequests_entity.dart';
import '../../domain/repositories/myRequests_repository.dart';
import '../datasources/myRequests_remote_datasource.dart';

class MyRequestsRepositoryImpl implements MyRequestsRepository {
  final NetworkInfo networkInfo;
  final MyRequestsRemoteDataSource myRequestsRemoteDataSource;

  MyRequestsRepositoryImpl(
      {required this.networkInfo, required this.myRequestsRemoteDataSource});

  @override
  Future<Either<Failure, MyRequestsEntity>> myRequests(myRequestsParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAttendance = await myRequestsRemoteDataSource.myRequests(
          userId: myRequestsParams.userId,
        );
        if (remoteAttendance.resultEntity.status == 200) {
          // await MyRequestsLocalDataSource.cacheAttendance(remoteAttendance);
          return Right(remoteAttendance);
        } else {
          return Left(Failure(400, 'GetMyRequests Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, MyRequestsEntity>> myRequestsPending(
      EmployeeParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAttendance =
            await myRequestsRemoteDataSource.myRequestsPending(
          userId: params.userId,
        );
        if (remoteAttendance.resultEntity.status == 200) {
          // await MyRequestsLocalDataSource.cacheAttendance(remoteAttendance);
          return Right(remoteAttendance);
        } else {
          return Left(Failure(400, 'GetMyRequests Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
