// ignore_for_file: file_names

import 'package:Attendace/core/error/failure.dart';
import 'package:Attendace/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/create_timeOff_entity.dart';
import '../entities/get_TimeOff_entity.dart';
import '../repositories/create_timeOff_repository.dart';

class CreateTimeOffUsecase
    implements UseCase<CreateTimeOffEntity, CreateTimeOffParams> {
  final CreateTimeOffRepository createTimeOffRepository;

  CreateTimeOffUsecase(this.createTimeOffRepository);

  @override
  Future<Either<Failure, CreateTimeOffEntity>> call(
          CreateTimeOffParams params) =>
      createTimeOffRepository.createTimeOff(params);
}

class GetTimeOffUsecase implements UseCase<GetTimeOffEntity, NoParams> {
  final CreateTimeOffRepository createTimeOffRepository;

  GetTimeOffUsecase(this.createTimeOffRepository);

  @override
  Future<Either<Failure, GetTimeOffEntity>> call(NoParams params) =>
      createTimeOffRepository.getTimeOff(params);
}
