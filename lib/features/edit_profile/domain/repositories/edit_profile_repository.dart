import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/edit_profile_entity.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, EditProfileEntity>> editUserName(
      EditProfileParams params);
  Future<Either<Failure, EditProfileEntity>> editDepartment(
      EditProfileParams params);
  Future<Either<Failure, EditProfileEntity>> editNoId(EditProfileParams params);
}
