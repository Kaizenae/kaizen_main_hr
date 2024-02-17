import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/features/create_timeOff/domain/entities/create_timeOff_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/accept_reject_request_entity.dart';
import '../../domain/repositories/accept_reject_request_repository.dart';
import '../datasources/accept_reject_request_datasource.dart';

class AcceptRejectRequestRepositoryImpl
    implements AcceptRejectRequestRepository {
  final NetworkInfo networkInfo;
  final AcceptRejectRequestRemoteDataSource acceptRejectRequestRemoteDataSource;

  AcceptRejectRequestRepositoryImpl(
      {required this.networkInfo,
      required this.acceptRejectRequestRemoteDataSource});

  @override
  Future<Either<Failure, AcceptRejectRequestEntity>> acceptRejectRequest(
      params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAcceptRejectRequest =
            await acceptRejectRequestRemoteDataSource.acceptRejectRequest(
          id: params.id,
          is_accept: params.is_accept,
          state: params.state,
        );
        if (remoteAcceptRejectRequest.resultEntity.status == true) {
          return Right(remoteAcceptRejectRequest);
        } else {
          return Left(
              Failure(400, remoteAcceptRejectRequest.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CreateTimeOffEntity>> acceptRejectTimeOff(
      AcceptRejectTimeOffParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAcceptRejectRequest =
            await acceptRejectRequestRemoteDataSource.acceptRejectTimeOff(
          leavesId: params.leavesId,
          state: params.state,
        );
        if (remoteAcceptRejectRequest.resultEntity.status == 200) {
          return Right(remoteAcceptRejectRequest);
        } else {
          return Left(
              Failure(400, remoteAcceptRejectRequest.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
