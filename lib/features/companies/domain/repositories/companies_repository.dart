import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/companies_entity.dart';

abstract class CompaniesRepository {
  Future<Either<Failure, CompaniesEntity>> companies(CompanyParams params);
}
