import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../create_timeOff/domain/entities/create_timeOff_entity.dart';
import '../entities/accept_reject_request_entity.dart';
import '../repositories/accept_reject_request_repository.dart';

class AcceptRejectRequestUsecase
    implements UseCase<AcceptRejectRequestEntity, AcceptRejectRequestParams> {
  final AcceptRejectRequestRepository acceptRejectRequestRepository;

  AcceptRejectRequestUsecase(this.acceptRejectRequestRepository);

  @override
  Future<Either<Failure, AcceptRejectRequestEntity>> call(
          AcceptRejectRequestParams params) =>
      acceptRejectRequestRepository.acceptRejectRequest(params);
}

class AcceptRejectTimeOffUsecase
    implements UseCase<CreateTimeOffEntity, AcceptRejectTimeOffParams> {
  final AcceptRejectRequestRepository acceptRejectTimeOffRepository;

  AcceptRejectTimeOffUsecase(this.acceptRejectTimeOffRepository);

  @override
  Future<Either<Failure, CreateTimeOffEntity>> call(
          AcceptRejectTimeOffParams params) =>
      acceptRejectTimeOffRepository.acceptRejectTimeOff(params);
}
