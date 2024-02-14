// ignore_for_file: file_names

import 'package:Attendace/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/create_timeOff_entity.dart';
import '../entities/get_TimeOff_entity.dart';

abstract class CreateTimeOffRepository {
  Future<Either<Failure, CreateTimeOffEntity>> createTimeOff(
      CreateTimeOffParams createTimeOffParams);
  Future<Either<Failure, GetTimeOffEntity>> getTimeOff(NoParams noParams);
}
