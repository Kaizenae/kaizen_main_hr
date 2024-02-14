import '../../domain/entities/edit_company_entity.dart';

abstract class EditCompanyStates {}

class InitEditCompanyState extends EditCompanyStates {}

class EditCompanyLoadingState extends EditCompanyStates {}

class EditCompanySuccessState extends EditCompanyStates {
  final EditCompanyEntity editCompanyEntity;

  EditCompanySuccessState({required this.editCompanyEntity});
}

class EditCompanyErrorState extends EditCompanyStates {
  final String message;

  EditCompanyErrorState({required this.message});
}
