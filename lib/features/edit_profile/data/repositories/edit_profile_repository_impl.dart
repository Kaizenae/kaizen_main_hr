import 'package:dartz/dartz.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/edit_profile_entity.dart';
import '../../domain/repositories/edit_profile_repository.dart';
import '../datasources/edit_profile_datasource.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final NetworkInfo networkInfo;
  final EditProfileRemoteDataSource editProfileRemoteDataSource;

  EditProfileRepositoryImpl(
      {required this.networkInfo, required this.editProfileRemoteDataSource});

  @override
  Future<Either<Failure, EditProfileEntity>> editUserName(editUserName) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEditProfile = await editProfileRemoteDataSource.editProfile(
            userName: editUserName.userName, userId: editUserName.userId);
        if (remoteEditProfile.resultEntity.status == true) {
          return Right(remoteEditProfile);
        } else {
          return Left(Failure(400, remoteEditProfile.resultEntity.message[0]));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, EditProfileEntity>> editDepartment(
      editDepartment) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEditProfile =
            await editProfileRemoteDataSource.editPhoneNumber(
          phoneNumber: editDepartment.phoneNumber,
          userId: editDepartment.userId,
        );
        if (remoteEditProfile.resultEntity.status == true) {
          return Right(remoteEditProfile);
        } else {
          return Left(Failure(400, remoteEditProfile.resultEntity.message[0]));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, EditProfileEntity>> editNoId(editDepartment) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEditProfile = await editProfileRemoteDataSource.editNoId(
            noId: editDepartment.noId, userId: editDepartment.userId);
        if (remoteEditProfile.resultEntity.status == true) {
          return Right(remoteEditProfile);
        } else {
          return Left(Failure(400, remoteEditProfile.resultEntity.message[0]));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
