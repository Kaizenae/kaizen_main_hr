import 'package:equatable/equatable.dart';

import '../../domain/entities/employee_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class LogoutState extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetEmployeeLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetEmployeeSuccess extends ProfileState {
  final EmployeeEntity employeeEntity;

  const GetEmployeeSuccess({required this.employeeEntity});
  @override
  List<Object> get props => [employeeEntity];
}

class GetEmployeeError extends ProfileState {
  final String message;

  const GetEmployeeError({required this.message});
  @override
  List<Object> get props => [message];
}

class GetEmployeesLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetEmployeesSuccess extends ProfileState {
  final EmployeeEntity employeeEntity;

  const GetEmployeesSuccess({required this.employeeEntity});
  @override
  List<Object> get props => [employeeEntity];
}

class GetEmployeesError extends ProfileState {
  final String message;

  const GetEmployeesError({required this.message});
  @override
  List<Object> get props => [message];
}
