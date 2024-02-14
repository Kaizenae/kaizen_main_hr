// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

import '../../../domain/entities/get_TimeOff_entity.dart';

abstract class TimeOffState extends Equatable {
  const TimeOffState();
}

class TimeOffInitial extends TimeOffState {
  @override
  List<Object> get props => [];
}

class GetTimeOffLoading extends TimeOffState {
  @override
  List<Object> get props => [];
}

class GetTimeOffSuccess extends TimeOffState {
  final GetTimeOffEntity getTimeOffEntity;

  const GetTimeOffSuccess({required this.getTimeOffEntity});

  @override
  List<Object> get props => [];
}

class GetTimeOffError extends TimeOffState {
  final String message;

  const GetTimeOffError({required this.message});

  @override
  List<Object> get props => [];
}
