// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

import '../../../../create_timeOff/domain/entities/create_timeOff_entity.dart';

abstract class AcceptRejectTimeOffState extends Equatable {}

class AcceptRejectTimeOfftInitial extends AcceptRejectTimeOffState {
  @override
  List<Object> get props => [];
}

class AcceptRejectTimeOffLoading extends AcceptRejectTimeOffState {
  @override
  List<Object> get props => [];
}

class AcceptRejectTimeOffSuccess extends AcceptRejectTimeOffState {
  final CreateTimeOffEntity createTimeOffEntity;

  AcceptRejectTimeOffSuccess({required this.createTimeOffEntity});
  @override
  List<Object> get props => [];
}

class AcceptRejectTimeOffError extends AcceptRejectTimeOffState {
  final String message;

  AcceptRejectTimeOffError({required this.message});
  @override
  List<Object> get props => [];
}
