// ignore_for_file: file_names

import 'package:Attendace/core/error/failure.dart';
import 'package:Attendace/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/create_timeOff_entity.dart';
import '../../domain/entities/get_TimeOff_entity.dart';
import '../../domain/repositories/create_timeOff_repository.dart';
import '../datasources/create_timeOff_remote_datasource.dart';

class CreateTimeOffRepositoryImpl implements CreateTimeOffRepository {
  final NetworkInfo networkInfo;
  final CreateTimeOffRemoteDataSource applyRequestRemoteDataSource;

  CreateTimeOffRepositoryImpl(
      {required this.networkInfo, required this.applyRequestRemoteDataSource});

  @override
  Future<Either<Failure, CreateTimeOffEntity>> createTimeOff(
      CreateTimeOffParams createTimeOffParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin = await applyRequestRemoteDataSource.createTimeOff(
          startDate: createTimeOffParams.startDate,
          endDate: createTimeOffParams.endDate,
          reason: createTimeOffParams.reason,
          userId: createTimeOffParams.userId,
          holidayStatus: createTimeOffParams.holidayStatus,
          attachment: createTimeOffParams.attachment,
        );

        if (remoteLogin.resultEntity.status == 200) {
          // await  loginLocalDataSource.cacheLogin(remoteLogin);
          return Right(remoteLogin);
        } else {
          return Left(Failure(400, remoteLogin.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, GetTimeOffEntity>> getTimeOff(
      NoParams noParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin = await applyRequestRemoteDataSource.getTimeoff();

        if (remoteLogin.resultEntity.status == 200) {
          // await  loginLocalDataSource.cacheLogin(remoteLogin);
          return Right(remoteLogin);
        } else {
          return Left(Failure(400, remoteLogin.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
