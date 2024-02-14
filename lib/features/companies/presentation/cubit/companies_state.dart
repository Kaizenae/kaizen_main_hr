import 'package:equatable/equatable.dart';

import '../../domain/entities/companies_entity.dart';

abstract class CompaniesState extends Equatable {
  const CompaniesState();
}

class CompaniesInitial extends CompaniesState {
  @override
  List<Object> get props => [];
}

class LogoutState extends CompaniesState {
  @override
  List<Object> get props => [];
}

class GetCompaniesLoading extends CompaniesState {
  @override
  List<Object> get props => [];
}

class GetCompaniesSuccess extends CompaniesState {
  final CompaniesEntity companiesEntity;

  const GetCompaniesSuccess({required this.companiesEntity});
  @override
  List<Object> get props => [companiesEntity];
}

class GetCompaniesError extends CompaniesState {
  final String message;

  const GetCompaniesError({required this.message});
  @override
  List<Object> get props => [message];
}

class GetCompanyLoading extends CompaniesState {
  @override
  List<Object> get props => [];
}

class GetCompanySuccess extends CompaniesState {
  final CompaniesEntity companiesEntity;

  const GetCompanySuccess({required this.companiesEntity});
  @override
  List<Object> get props => [companiesEntity];
}

class GetCompanyError extends CompaniesState {
  final String message;

  const GetCompanyError({required this.message});
  @override
  List<Object> get props => [message];
}
