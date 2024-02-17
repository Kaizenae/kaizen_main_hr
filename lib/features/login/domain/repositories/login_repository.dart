import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login(LoginParams params);
}
