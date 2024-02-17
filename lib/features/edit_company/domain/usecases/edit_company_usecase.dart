import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/edit_company_entity.dart';
import '../repositories/edit_company_repository.dart';

class EditLocationUsecase
    implements UseCase<EditCompanyEntity, EditCompanyParams> {
  final EditCompanyRepository editCompanyRepository;

  EditLocationUsecase(this.editCompanyRepository);

  @override
  Future<Either<Failure, EditCompanyEntity>> call(EditCompanyParams params) =>
      editCompanyRepository.editLocation(params);
}
