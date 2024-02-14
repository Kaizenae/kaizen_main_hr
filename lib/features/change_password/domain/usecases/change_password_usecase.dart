import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/change_password_entity.dart';
import '../repositories/change_password_repository.dart';

class EditChangePasswordUsecase
    implements UseCase<ChangePasswordEntity, ChangePasswordParams> {
  final ChangePasswordRepository editProfileRepository;

  EditChangePasswordUsecase(this.editProfileRepository);

  @override
  Future<Either<Failure, ChangePasswordEntity>> call(
          ChangePasswordParams params) =>
      editProfileRepository.changePasswordName(params);
}
