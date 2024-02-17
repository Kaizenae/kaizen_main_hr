import 'package:Attendace/features/create_request/domain/entities/apply_request_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ApplyRequestState extends Equatable {
  const ApplyRequestState();
}

class ApplyRequestInitial extends ApplyRequestState {
  @override
  List<Object> get props => [];
}

class CheckTypeStateLoading extends ApplyRequestState {
  @override
  List<Object> get props => [];
}

class CheckTypeStateSuccess extends ApplyRequestState {
  @override
  List<Object> get props => [];
}

class ApplyRequestLoading extends ApplyRequestState {
  @override
  List<Object> get props => [];
}

class ApplyRequestSuccess extends ApplyRequestState {
  final ApplyRequestEntity applyRequestEntity;

  const ApplyRequestSuccess({required this.applyRequestEntity});
  @override
  List<Object> get props => [];
}

class ApplyRequestError extends ApplyRequestState {
  final String message;

  const ApplyRequestError({required this.message});
  @override
  List<Object> get props => [];
}
