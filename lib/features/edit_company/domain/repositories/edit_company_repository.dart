import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/edit_company_entity.dart';

abstract class EditCompanyRepository {
  Future<Either<Failure, EditCompanyEntity>> editLocation(
      EditCompanyParams params);
}
