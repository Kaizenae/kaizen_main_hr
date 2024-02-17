import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employees_entity.dart';

abstract class EmployeesRepository {
  Future<Either<Failure, EmployeesEntity>> employees(NoParams params);
}
