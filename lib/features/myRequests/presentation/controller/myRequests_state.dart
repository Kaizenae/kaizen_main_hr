// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

import '../../domain/entities/myRequests_entity.dart';

abstract class MyRequestsState extends Equatable {
  const MyRequestsState();
}

class MyRequestsInitial extends MyRequestsState {
  @override
  List<Object> get props => [];
}

class GetMyRequestsLoading extends MyRequestsState {
  @override
  List<Object> get props => [];
}

class GetMyRequestsSuccess extends MyRequestsState {
  final MyRequestsEntity myRequestsEntity;

  const GetMyRequestsSuccess({required this.myRequestsEntity});

  @override
  List<Object> get props => [myRequestsEntity];
}

class GetMyRequestsError extends MyRequestsState {
  final String message;

  const GetMyRequestsError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetEmployeeRequestsLoading extends MyRequestsState {
  @override
  List<Object> get props => [];
}

class GetEmployeeRequestsSuccess extends MyRequestsState {
  final MyRequestsEntity myRequestsEntity;

  const GetEmployeeRequestsSuccess({required this.myRequestsEntity});

  @override
  List<Object> get props => [myRequestsEntity];
}

class GetEmployeeRequestsError extends MyRequestsState {
  final String message;

  const GetEmployeeRequestsError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetMyRequestsPendingLoading extends MyRequestsState {
  @override
  List<Object> get props => [];
}

class GetMyRequestsPendingSuccess extends MyRequestsState {
  final MyRequestsEntity myRequestsEntity;

  const GetMyRequestsPendingSuccess({required this.myRequestsEntity});

  @override
  List<Object> get props => [myRequestsEntity];
}

class GetMyRequestsPendingError extends MyRequestsState {
  final String message;

  const GetMyRequestsPendingError({required this.message});

  @override
  List<Object> get props => [message];
}
