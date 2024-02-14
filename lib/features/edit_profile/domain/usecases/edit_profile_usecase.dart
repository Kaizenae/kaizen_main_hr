import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/edit_profile_entity.dart';
import '../repositories/edit_profile_repository.dart';

class EditUserNameUsecase
    implements UseCase<EditProfileEntity, EditProfileParams> {
  final EditProfileRepository editProfileRepository;

  EditUserNameUsecase(this.editProfileRepository);

  @override
  Future<Either<Failure, EditProfileEntity>> call(EditProfileParams params) =>
      editProfileRepository.editUserName(params);
}

class EditDepartmentUsecase
    implements UseCase<EditProfileEntity, EditProfileParams> {
  final EditProfileRepository editProfileRepository;

  EditDepartmentUsecase(this.editProfileRepository);

  @override
  Future<Either<Failure, EditProfileEntity>> call(EditProfileParams params) =>
      editProfileRepository.editDepartment(params);
}

class EditNoIdUsecase implements UseCase<EditProfileEntity, EditProfileParams> {
  final EditProfileRepository editProfileRepository;

  EditNoIdUsecase(this.editProfileRepository);

  @override
  Future<Either<Failure, EditProfileEntity>> call(EditProfileParams params) =>
      editProfileRepository.editNoId(params);
}
