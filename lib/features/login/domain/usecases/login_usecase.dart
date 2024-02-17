import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repository.dart';

class LoginUsecase implements UseCase<LoginEntity, LoginParams> {
  final LoginRepository loginRepository;

  LoginUsecase(this.loginRepository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) =>
      loginRepository.login(params);
}
