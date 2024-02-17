// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

import '../../domain/entities/myLoans_entity.dart';

abstract class MyLoansState extends Equatable {
  const MyLoansState();
}

class MyLoansInitial extends MyLoansState {
  @override
  List<Object> get props => [];
}

class GetMyLoansLoading extends MyLoansState {
  @override
  List<Object> get props => [];
}

class GetMyLoansSuccess extends MyLoansState {
  final MyLoansEntity myLoansEntity;

  const GetMyLoansSuccess({required this.myLoansEntity});

  @override
  List<Object> get props => [myLoansEntity];
}

class GetMyLoansError extends MyLoansState {
  final String message;

  const GetMyLoansError({required this.message});

  @override
  List<Object> get props => [message];
}

class CancelMyLoansLoading extends MyLoansState {
  @override
  List<Object> get props => [];
}

class CancelMyLoansSuccess extends MyLoansState {
  final MyLoansEntity myLoansEntity;

  const CancelMyLoansSuccess({required this.myLoansEntity});

  @override
  List<Object> get props => [myLoansEntity];
}

class CancelMyLoansError extends MyLoansState {
  final String message;

  const CancelMyLoansError({required this.message});

  @override
  List<Object> get props => [message];
}
