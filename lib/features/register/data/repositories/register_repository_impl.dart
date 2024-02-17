import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_datasource.dart';
import '../datasources/register_local_datasource.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final NetworkInfo networkInfo;
  final RegisterRemoteDataSource registerRemoteDataSource;
  final RegisterLocalDataSource registerLocalDataSource;

  RegisterRepositoryImpl(
      {required this.registerLocalDataSource,
      required this.networkInfo,
      required this.registerRemoteDataSource});

  @override
  Future<Either<Failure, RegisterEntity>> register(registerParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRegister = await registerRemoteDataSource.register(
          email: registerParams.email,
          name: registerParams.name,
          phoneNumber: registerParams.phoneNumber,
          password: registerParams.password,
          companyId: registerParams.companyId,
          uniqueDeviceId: registerParams.uniqueDeviceId,
          empCode: registerParams.employeeCode,
        );
        if (remoteRegister.resultEntity.status == true) {
          // await  registerLocalDataSource.cacheRegister(remoteRegister);
          return Right(remoteRegister);
        } else {
          return Left(Failure(400, remoteRegister.resultEntity.message[0]));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
