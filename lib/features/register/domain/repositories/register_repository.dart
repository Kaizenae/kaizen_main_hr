import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/register_entity.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterEntity>> register(RegisterParams params);
}
