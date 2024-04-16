import 'package:Attendace/features/attendance/domain/entities/attendace_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();
}

class AttendanceInitial extends AttendanceState {
  @override
  List<Object> get props => [];
}

class GetAttendanceLoading extends AttendanceState {
  @override
  List<Object> get props => [];
}

class GetAttendanceSuccess extends AttendanceState {
  final AttendanceEntity attendanceEntity;

  const GetAttendanceSuccess({required this.attendanceEntity});

  @override
  List<Object> get props => [attendanceEntity];
}

class GetAttendanceError extends AttendanceState {
  final String message;

  const GetAttendanceError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetEmployeeAttendanceLoading extends AttendanceState {
  @override
  List<Object> get props => [];
}

class GetEmployeeAttendanceSuccess extends AttendanceState {
  final AttendanceEntity attendanceEntity;

  const GetEmployeeAttendanceSuccess({required this.attendanceEntity});

  @override
  List<Object> get props => [attendanceEntity];
}

class GetEmployeeAttendanceError extends AttendanceState {
  final String message;

  const GetEmployeeAttendanceError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetOddPunchLoadingState extends AttendanceState {
  @override
  List<Object> get props => [];
}

class GetOddPunchSuccessState extends AttendanceState {
  const GetOddPunchSuccessState();

  @override
  List<Object> get props => [];
}

class GetOddPunchErrorState extends AttendanceState {
  const GetOddPunchErrorState();

  @override
  List<Object> get props => [];
}
