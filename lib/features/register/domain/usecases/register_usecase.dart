import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/register_entity.dart';
import '../repositories/register_repository.dart';

class RegisterUsecase implements UseCase<RegisterEntity, RegisterParams> {
  final RegisterRepository registerRepository;

  RegisterUsecase(this.registerRepository);

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) =>
      registerRepository.register(params);
}
