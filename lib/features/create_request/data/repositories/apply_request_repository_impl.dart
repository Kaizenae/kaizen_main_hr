import 'package:Attendace/core/error/failure.dart';
import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/features/create_request/domain/entities/apply_request_entity.dart';
import 'package:Attendace/features/create_request/domain/repositories/apply_request_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/apply_request_remote_datasource.dart';

class ApplyRequestRepositoryImpl implements ApplyRequestRepository {
  final NetworkInfo networkInfo;
  final ApplyRequestRemoteDataSource applyRequestRemoteDataSource;

  ApplyRequestRepositoryImpl(
      {required this.networkInfo, required this.applyRequestRemoteDataSource});

  @override
  Future<Either<Failure, ApplyRequestEntity>> applyRequest(
      ApplyRequestParams applyRequestParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin = await applyRequestRemoteDataSource.applyRequest(
            message: applyRequestParams.message,
            date: applyRequestParams.date,
            distance: applyRequestParams.distance,
            userId: applyRequestParams.userId,
            location: applyRequestParams.location,
            check_type: applyRequestParams.check_type);

        if (remoteLogin.resultEntity.status == true) {
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
