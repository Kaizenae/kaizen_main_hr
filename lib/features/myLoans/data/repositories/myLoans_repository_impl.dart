// ignore_for_file: file_names

import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/myLoans_entity.dart';
import '../../domain/repositories/myLoans_repository.dart';
import '../datasources/myLoans_remote_datasource.dart';

class MyLoansRepositoryImpl implements MyLoansRepository {
  final NetworkInfo networkInfo;
  final MyLoansRemoteDataSource myLoansRemoteDataSource;

  MyLoansRepositoryImpl(
      {required this.networkInfo, required this.myLoansRemoteDataSource});

  @override
  Future<Either<Failure, MyLoansEntity>> myLoans(myLeavesParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAttendance = await myLoansRemoteDataSource.myLoans(
            userId: myLeavesParams.userId);
        if (remoteAttendance.resultEntity.status == 200) {
          // await MyLeavesLocalDataSource.cacheAttendance(remoteAttendance);
          return Right(remoteAttendance);
        } else {
          return Left(Failure(400, 'GetMyLeaves Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, MyLoansEntity>> cancelMyLoans(
      cancelMyLeavesParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAttendance = await myLoansRemoteDataSource.cancelMyLoans(
            userId: cancelMyLeavesParams.userId,
            loanId: cancelMyLeavesParams.loanId,
            state: cancelMyLeavesParams.state);
        if (remoteAttendance.resultEntity.status == 200) {
          // await MyLeavesLocalDataSource.cacheAttendance(remoteAttendance);
          return Right(remoteAttendance);
        } else {
          return Left(Failure(400, 'GetMyLeaves Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
