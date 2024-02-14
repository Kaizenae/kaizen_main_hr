// ignore_for_file: file_names

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/punchInOut_entity.dart';
import '../repositories/punchInOut_repository.dart';

class PunchInOutUsecase implements UseCase<PunchInOutEntity, EmployeeParams> {
  final PunchInOutRepository punchInOutRepository;

  PunchInOutUsecase(this.punchInOutRepository);

  @override
  Future<Either<Failure, PunchInOutEntity>> call(EmployeeParams params) =>
      punchInOutRepository.punchInOut(params);
}
