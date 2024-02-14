import 'package:Attendace/core/error/failure.dart';
import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/features/create_request/domain/entities/apply_request_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ApplyRequestRepository {
  Future<Either<Failure, ApplyRequestEntity>> applyRequest(
      ApplyRequestParams applyRequestParams);
}
