import 'package:Attendace/core/error/failure.dart';
import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/features/create_request/domain/repositories/apply_request_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/apply_request_entity.dart';

class ApplyRequestUsecase
    implements UseCase<ApplyRequestEntity, ApplyRequestParams> {
  final ApplyRequestRepository applyRequestRepository;

  ApplyRequestUsecase(this.applyRequestRepository);

  @override
  Future<Either<Failure, ApplyRequestEntity>> call(ApplyRequestParams params) =>
      applyRequestRepository.applyRequest(params);
}
