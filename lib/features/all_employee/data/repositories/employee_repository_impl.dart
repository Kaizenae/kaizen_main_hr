import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/employees_entity.dart';
import '../../domain/repositories/employees_repository.dart';
import '../datasources/employee_remote_datasource.dart';

class EmployeesRepositoryImpl implements EmployeesRepository {
  final NetworkInfo networkInfo;
  final EmployeesRemoteDataSource employeesRemoteDataSource;

  EmployeesRepositoryImpl(
      {required this.networkInfo, required this.employeesRemoteDataSource});

  @override
  Future<Either<Failure, EmployeesEntity>> employees(employeeParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await employeesRemoteDataSource.employees();
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
