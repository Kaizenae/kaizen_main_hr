// ignore_for_file: file_names, non_constant_identifier_names

import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/punchInOut_entity.dart';
import '../../domain/repositories/punchInOut_repository.dart';
import '../datasources/punchInOut_remote_datasource.dart';

class PunchInOutRepositoryImpl implements PunchInOutRepository {
  final NetworkInfo networkInfo;
  final PunchInOutRemoteDataSource punchInOutRemoteDataSource;

  PunchInOutRepositoryImpl(
      {required this.networkInfo, required this.punchInOutRemoteDataSource});

  @override
  Future<Either<Failure, PunchInOutEntity>> punchInOut(PunchInOutParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePunchInOut = await punchInOutRemoteDataSource.punchInOut(
          userId: PunchInOutParams.userId,
        );
        if (remotePunchInOut.resultEntity.status == true) {
          // await  PunchInOutLocalDataSource.cachePunchInOut(remotePunchInOut);
          return Right(remotePunchInOut);
        } else {
          return Left(Failure(400, remotePunchInOut.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
