import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../domain/entities/companies_entity.dart';
import '../../domain/usecases/companies_usecase.dart';
import 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  final CompaniesUsecase companiesUsecase;

  CompaniesCubit({required this.companiesUsecase}) : super(CompaniesInitial());

  static CompaniesCubit get(context) => BlocProvider.of(context);

  Future<void> getCompaniesFun() async {
    emit(GetCompaniesLoading());
    Either<Failure, CompaniesEntity> response =
        await companiesUsecase(const CompanyParams(companyId: 0));

    emit(response.fold((failure) {
      return GetCompaniesError(message: failure.message);
    }, (companiesEntity) {
      return GetCompaniesSuccess(companiesEntity: companiesEntity);
    }));
  }

  Future<void> getCompanyFun() async {
    emit(GetCompanyLoading());
    Either<Failure, CompaniesEntity> response = await companiesUsecase(
        CompanyParams(companyId: AppConstants.companyId));

    emit(response.fold((failure) {
      return GetCompanyError(message: failure.message);
    }, (companiesEntity) {
      return GetCompanySuccess(companiesEntity: companiesEntity);
    }));
  }
}
