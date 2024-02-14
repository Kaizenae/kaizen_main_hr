import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/companies_entity.dart';
import '../repositories/companies_repository.dart';

class CompaniesUsecase implements UseCase<CompaniesEntity, CompanyParams> {
  final CompaniesRepository companiesRepository;

  CompaniesUsecase(this.companiesRepository);

  @override
  Future<Either<Failure, CompaniesEntity>> call(CompanyParams params) =>
      companiesRepository.companies(params);
}
