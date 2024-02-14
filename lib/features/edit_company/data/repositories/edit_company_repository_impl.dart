import 'package:dartz/dartz.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/edit_company_entity.dart';
import '../../domain/repositories/edit_company_repository.dart';
import '../datasources/edit_company_datasource.dart';

class EditCompanyRepositoryImpl implements EditCompanyRepository {
  final NetworkInfo networkInfo;
  final EditCompanyRemoteDataSource editCompanyRemoteDataSource;

  EditCompanyRepositoryImpl(
      {required this.networkInfo, required this.editCompanyRemoteDataSource});

  @override
  Future<Either<Failure, EditCompanyEntity>> editLocation(editUserName) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEditProfile =
            await editCompanyRemoteDataSource.editLocation(
                long: editUserName.long,
                lat: editUserName.lat,
                companyId: editUserName.companyId);
        if (remoteEditProfile.resultEntity.status == true) {
          return Right(remoteEditProfile);
        } else {
          return Left(Failure(400, remoteEditProfile.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
