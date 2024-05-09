import 'package:Attendace/features/home/domain/entities/punchInOut_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class CheckInAndOutLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class CheckOutLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class CheckInAndOutSuccess extends HomeState {
  final PunchInOutEntity punchInOutEntity;

  const CheckInAndOutSuccess({required this.punchInOutEntity});
  @override
  List<Object> get props => [];
}

class CheckInAndOutError extends HomeState {
  final String message;

  const CheckInAndOutError({required this.message});

  @override
  List<Object> get props => [message];
}

class PunchChangeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class PunchChange extends HomeState {
  @override
  List<Object> get props => [];
}

class ChangePunchAndInPunchOutLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class ChangePunchAndInPunchOutSuccessState extends HomeState {
  @override
  List<Object> get props => [];
}
