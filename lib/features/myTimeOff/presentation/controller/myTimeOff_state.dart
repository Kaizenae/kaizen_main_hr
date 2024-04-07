// ignore_for_file: file_names

import 'package:Attendace/features/myTimeOff/domain/entities/myTimeOff_entity.dart';
import 'package:equatable/equatable.dart';

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
  const GetMyTimeOffSuccess({required MyTimeOffEntity myTimeOffEntity});

  @override
  List<Object> get props => [];
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
  const GetMyTimeOffPendingSuccess();

  @override
  List<Object> get props => [];
}

class GetMyTimeOffPendingError extends MyTimeOffState {
  final String message;

  const GetMyTimeOffPendingError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetTimeOffValueLoading extends MyTimeOffState {
  @override
  List<Object> get props => [];
}

class GetTimeOffValueSuccess extends MyTimeOffState {
  const GetTimeOffValueSuccess();

  @override
  List<Object> get props => [];
}

class GetTimeOffValueError extends MyTimeOffState {
  const GetTimeOffValueError();

  @override
  List<Object> get props => [];
}

class GetTimeOffNameAndValueLoading extends MyTimeOffState {
  const GetTimeOffNameAndValueLoading();

  @override
  List<Object?> get props => [];
}

class GetTimeOffNameAndValueSuccess extends MyTimeOffState {
  const GetTimeOffNameAndValueSuccess();

  @override
  List<Object?> get props => [];
}

class GetTimeOffNameAndValueError extends MyTimeOffState {
  const GetTimeOffNameAndValueError();

  @override
  List<Object?> get props => [];
}

class CancelMyRequestLoadingState extends MyTimeOffState {
  const CancelMyRequestLoadingState();

  @override
  List<Object?> get props => [];
}

class CancelMyRequestSuccessState extends MyTimeOffState {
  final String message;
  const CancelMyRequestSuccessState({required this.message});

  @override
  List<Object?> get props => [];
}

class CancelMyRequestErrorState extends MyTimeOffState {
  final String message;

  const CancelMyRequestErrorState({required this.message});

  @override
  List<Object?> get props => [];
}
