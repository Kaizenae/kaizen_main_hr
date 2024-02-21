// ignore_for_file: valid_regexps

import 'package:dartz/dartz.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/change_password_entity.dart';
import '../../domain/repositories/change_password_repository.dart';
import '../datasources/change_password_datasource.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final NetworkInfo networkInfo;
  final ChangePasswordRemoteDataSource changePasswordRemoteDataSource;

  ChangePasswordRepositoryImpl(
      {required this.networkInfo,
      required this.changePasswordRemoteDataSource});

  @override
  Future<Either<Failure, ChangePasswordEntity>> changePasswordName(
      changePasswordParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChangePassword =
            await changePasswordRemoteDataSource.changePassword(
          userId: changePasswordParams.userId,
          oldPassword: changePasswordParams.oldPassword,
          newPassword: changePasswordParams.newPassword,
        );
        if (remoteChangePassword.resultEntity.status == true) {
          return Right(remoteChangePassword);
        } else {
          return Left(Failure(
            400,
            remoteChangePassword.resultEntity.message
                .toString()
                .replaceAll(RegExp('"'), " ")
                .replaceAll(RegExp(r'[\[\]]'), ''),
          ));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
