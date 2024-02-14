// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

import '../../domain/entities/create_timeOff_entity.dart';

abstract class CreateTimeOffState extends Equatable {
  const CreateTimeOffState();
}

class CreateTimeOffInitial extends CreateTimeOffState {
  @override
  List<Object> get props => [];
}

class TimeOffLoading extends CreateTimeOffState {
  @override
  List<Object> get props => [];
}

class TimeOffSuccess extends CreateTimeOffState {
  @override
  List<Object> get props => [];
}

class CheckTypeStateLoading extends CreateTimeOffState {
  @override
  List<Object> get props => [];
}

class CheckTypeStateSuccess extends CreateTimeOffState {
  @override
  List<Object> get props => [];
}

class CurrencyLoading extends CreateTimeOffState {
  @override
  List<Object> get props => [];
}

class ChangeSelectedDateState extends CreateTimeOffState {
  @override
  List<Object> get props => [];
}

class CreateTimeOffLoading extends CreateTimeOffState {
  @override
  List<Object> get props => [];
}

class CreateTimeOffSuccess extends CreateTimeOffState {
  final CreateTimeOffEntity createTimeOffEntity;

  const CreateTimeOffSuccess({required this.createTimeOffEntity});
  @override
  List<Object> get props => [];
}

class CreateTimeOffError extends CreateTimeOffState {
  final String message;

  const CreateTimeOffError({required this.message});
  @override
  List<Object> get props => [];
}
