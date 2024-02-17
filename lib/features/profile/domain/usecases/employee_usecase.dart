import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee_entity.dart';
import '../repositories/employee_repository.dart';

class EmployeeUsecase implements UseCase<EmployeeEntity, EmployeeParams> {
  final EmployeeRepository employeeRepository;

  EmployeeUsecase(this.employeeRepository);

  @override
  Future<Either<Failure, EmployeeEntity>> call(EmployeeParams params) =>
      employeeRepository.employee(params);
}

class EmployeessUsecase implements UseCase<EmployeeEntity, EmployeeParams> {
  final EmployeeRepository employeeRepository;

  EmployeessUsecase(this.employeeRepository);

  @override
  Future<Either<Failure, EmployeeEntity>> call(EmployeeParams params) =>
      employeeRepository.employees(params);
}
