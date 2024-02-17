import 'package:equatable/equatable.dart';

import '../../domain/entities/employees_entity.dart';

abstract class AllEmployeesState extends Equatable {
  const AllEmployeesState();
}

class AllEmployeesInitial extends AllEmployeesState {
  @override
  List<Object> get props => [];
}

class LogoutState extends AllEmployeesState {
  @override
  List<Object> get props => [];
}

class GetEmployeesLoading extends AllEmployeesState {
  @override
  List<Object> get props => [];
}

class GetEmployeesSuccess extends AllEmployeesState {
  final EmployeesEntity employeeEntity;

  const GetEmployeesSuccess({required this.employeeEntity});
  @override
  List<Object> get props => [employeeEntity];
}

class GetEmployeesError extends AllEmployeesState {
  final String message;

  const GetEmployeesError({required this.message});
  @override
  List<Object> get props => [message];
}
