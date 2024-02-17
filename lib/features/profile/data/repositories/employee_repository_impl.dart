import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasources/employee_remote_datasource.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final NetworkInfo networkInfo;
  final EmployeeRemoteDataSource employeeRemoteDataSource;

  EmployeeRepositoryImpl(
      {required this.networkInfo, required this.employeeRemoteDataSource});

  @override
  Future<Either<Failure, EmployeeEntity>> employee(employeeParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await employeeRemoteDataSource.employee(
          userId: employeeParams.userId,
        );
        if (remoteEmployee.resultEntity.status == 200) {
          await CacheHelper.put(
              key: AppStrings.employeeName,
              value: remoteEmployee.resultEntity.response[0].name);
          AppConstants.employeeName =
              await CacheHelper.get(key: AppStrings.employeeName);
          await CacheHelper.put(
              key: AppStrings.company,
              value: remoteEmployee.resultEntity.response[0].companyId);
          AppConstants.companyId =
              await CacheHelper.get(key: AppStrings.company);
          // await  employeeLocalDataSource.cacheEmployee(remoteEmployee);
          return Right(remoteEmployee);
        } else {
          return Left(Failure(400, 'Get Employee Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> employees(employeeParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await employeeRemoteDataSource.employees();
        if (remoteEmployee.resultEntity.status == 200) {
          return Right(remoteEmployee);
        } else {
          return Left(Failure(400, 'Get Employee Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
