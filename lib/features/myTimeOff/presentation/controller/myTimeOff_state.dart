// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

import '../../domain/entities/myTimeOff_entity.dart';

abstract class MyTimeOffState extends Equatable {
  const MyTimeOffState();
}

class MyTimeOffInitial extends MyTimeOffState {
  @override
  List<Object> get props => [];
}

class GetMyTimeOffLoading extends MyTimeOffState {
  @override
  List<Object> get props => [];
}

class GetMyTimeOffSuccess extends MyTimeOffState {
  final MyTimeOffEntity myTimeOffEntity;

  const GetMyTimeOffSuccess({required this.myTimeOffEntity});

  @override
  List<Object> get props => [myTimeOffEntity];
}

class GetMyTimeOffError extends MyTimeOffState {
  final String message;

  const GetMyTimeOffError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetMyTimeOffPendingLoading extends MyTimeOffState {
  @override
  List<Object> get props => [];
}

class GetMyTimeOffPendingSuccess extends MyTimeOffState {
  final MyTimeOffEntity myTimeOffEntity;

  const GetMyTimeOffPendingSuccess({required this.myTimeOffEntity});

  @override
  List<Object> get props => [myTimeOffEntity];
}

class GetMyTimeOffPendingError extends MyTimeOffState {
  final String message;

  const GetMyTimeOffPendingError({required this.message});

  @override
  List<Object> get props => [message];
}
