import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/companies_entity.dart';
import '../../domain/repositories/companies_repository.dart';
import '../datasources/companies_remote_datasource.dart';

class CompaniesRepositoryImpl implements CompaniesRepository {
  final NetworkInfo networkInfo;
  final CompaniesRemoteDataSource companiesRemoteDataSource;

  CompaniesRepositoryImpl(
      {required this.networkInfo, required this.companiesRemoteDataSource});

  @override
  Future<Either<Failure, CompaniesEntity>> companies(companiesParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await companiesRemoteDataSource.companies(
            companyId: companiesParams.companyId);
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
