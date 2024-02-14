import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, EmployeeEntity>> employee(EmployeeParams params);
  Future<Either<Failure, EmployeeEntity>> employees(EmployeeParams params);
}
