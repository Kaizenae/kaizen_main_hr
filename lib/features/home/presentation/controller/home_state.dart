import 'package:Attendace/features/home/domain/entities/punchInOut_entity.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class CheckInAndOutLoading extends HomeState {}

class CheckOutLoading extends HomeState {}

class CheckInAndOutSuccess extends HomeState {
  final PunchInOutEntity punchInOutEntity;

  const CheckInAndOutSuccess({required this.punchInOutEntity});
}

class CheckInAndOutError extends HomeState {
  final String message;

  const CheckInAndOutError({required this.message});
}

class PunchChangeLoading extends HomeState {}

class PunchChange extends HomeState {}

class ChangePunchAndInPunchOutLoadingState extends HomeState {}

class ChangePunchAndInPunchOutSuccessState extends HomeState {}

class ChangeIsMoreState extends HomeState {}
