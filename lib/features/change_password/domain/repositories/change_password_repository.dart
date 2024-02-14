import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/change_password_entity.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, ChangePasswordEntity>> changePasswordName(
      ChangePasswordParams params);
}
