import 'package:equatable/equatable.dart';

import '../../../domain/entities/accept_reject_request_entity.dart';

abstract class AcceptRejectRequestState extends Equatable {}

class AcceptRejectRequestInitial extends AcceptRejectRequestState {
  @override
  List<Object> get props => [];
}

class AcceptRejectRequestLoading extends AcceptRejectRequestState {
  @override
  List<Object> get props => [];
}

class AcceptRejectRequestSuccess extends AcceptRejectRequestState {
  final AcceptRejectRequestEntity acceptRejectRequestEntity;

  AcceptRejectRequestSuccess({required this.acceptRejectRequestEntity});
  @override
  List<Object> get props => [];
}

class AcceptRejectRequestError extends AcceptRejectRequestState {
  final String message;

  AcceptRejectRequestError({required this.message});
  @override
  List<Object> get props => [];
}
