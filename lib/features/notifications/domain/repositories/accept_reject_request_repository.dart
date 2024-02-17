import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../create_timeOff/domain/entities/create_timeOff_entity.dart';
import '../entities/accept_reject_request_entity.dart';

abstract class AcceptRejectRequestRepository {
  Future<Either<Failure, AcceptRejectRequestEntity>> acceptRejectRequest(
      AcceptRejectRequestParams params);
  Future<Either<Failure, CreateTimeOffEntity>> acceptRejectTimeOff(
      AcceptRejectTimeOffParams params);
}
