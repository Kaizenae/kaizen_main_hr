// ignore_for_file: valid_regexps

import 'package:Attendace/core/local/cache_helper.dart';
import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_datasource.dart';
import '../datasources/login_local_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource loginRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;

  LoginRepositoryImpl(
      {required this.loginLocalDataSource,
      required this.networkInfo,
      required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, LoginEntity>> login(loginParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin = await loginRemoteDataSource.login(
            email: loginParams.email,
            password: loginParams.password,
            uniqueDeviceId: loginParams.uniqueDeviceId);
        await CacheHelper.put(
            key: AppStrings.token, value: remoteLogin.resultEntity.id);
        await CacheHelper.put(
            key: AppStrings.admin, value: remoteLogin.resultEntity.admin);
        await CacheHelper.put(
            key: AppStrings.company, value: remoteLogin.resultEntity.companyId);
        AppConstants.token = await CacheHelper.get(key: AppStrings.token);
        AppConstants.admin = await CacheHelper.get(key: AppStrings.admin);
        AppConstants.companyId = await CacheHelper.get(key: AppStrings.company);
        if (remoteLogin.resultEntity.status == true) {
          // await  loginLocalDataSource.cacheLogin(remoteLogin);
          return Right(remoteLogin);
        } else {
          return Left(Failure(
              400,
              remoteLogin.resultEntity.message
                  .toString()
                  .replaceAll(RegExp("["), " ")
                  .replaceAll(RegExp("]"), " ")
                  .replaceAll(RegExp('"'), " ")));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
