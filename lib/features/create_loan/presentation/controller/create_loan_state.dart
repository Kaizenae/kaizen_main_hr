import 'package:equatable/equatable.dart';

import '../../domain/entities/create_loan_entity.dart';

abstract class CreateLoanState extends Equatable {
  const CreateLoanState();
}

class CreateLoanInitial extends CreateLoanState {
  @override
  List<Object> get props => [];
}

class CheckTypeStateLoading extends CreateLoanState {
  @override
  List<Object> get props => [];
}

class CheckTypeStateSuccess extends CreateLoanState {
  @override
  List<Object> get props => [];
}

class CurrencyLoading extends CreateLoanState {
  @override
  List<Object> get props => [];
}

class CurrencySuccess extends CreateLoanState {
  @override
  List<Object> get props => [];
}

class CreateLoanLoading extends CreateLoanState {
  @override
  List<Object> get props => [];
}

class CreateLoanSuccess extends CreateLoanState {
  final CreateLoanEntity createLoanEntity;

  const CreateLoanSuccess({required this.createLoanEntity});
  @override
  List<Object> get props => [];
}

class CreateLoanError extends CreateLoanState {
  final String message;

  const CreateLoanError({required this.message});
  @override
  List<Object> get props => [];
}
