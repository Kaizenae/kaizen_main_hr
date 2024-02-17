import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employees_entity.dart';
import '../repositories/employees_repository.dart';

class EmployeesUsecase implements UseCase<EmployeesEntity, NoParams> {
  final EmployeesRepository employeeRepository;

  EmployeesUsecase(this.employeeRepository);

  @override
  Future<Either<Failure, EmployeesEntity>> call(NoParams params) =>
      employeeRepository.employees(params);
}
