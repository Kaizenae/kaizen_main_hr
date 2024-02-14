import 'package:Attendace/core/error/failure.dart';
import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/features/create_loan/domain/entities/get_currency_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/create_loan_entity.dart';
import '../../domain/repositories/create_loan_repository.dart';
import '../datasources/create_loan_remote_datasource.dart';

class CreateLoanRepositoryImpl implements CreateLoanRepository {
  final NetworkInfo networkInfo;
  final CreateLoanRemoteDataSource applyRequestRemoteDataSource;

  CreateLoanRepositoryImpl(
      {required this.networkInfo, required this.applyRequestRemoteDataSource});

  @override
  Future<Either<Failure, CreateLoanEntity>> createLoan(
      CreateLoanParams createLoanParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin = await applyRequestRemoteDataSource.createLoan(
          currencyId: createLoanParams.currencyId,
          loanAmount: createLoanParams.loanAmount,
          userId: createLoanParams.userId,
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
  Future<Either<Failure, GetCurrencyEntity>> getCurrency(
      NoParams noParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin = await applyRequestRemoteDataSource.getCurrency();

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
