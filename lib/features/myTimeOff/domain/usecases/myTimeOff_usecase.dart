// ignore_for_file: file_names

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/myTimeOff_entity.dart';
import '../repositories/myTimeOff_repository.dart';

class MyTimeOffUsecase implements UseCase<MyTimeOffEntity, EmployeeParams> {
  final MyTimeOffRepository myTimeOffRepository;

  MyTimeOffUsecase(this.myTimeOffRepository);

  @override
  Future<Either<Failure, MyTimeOffEntity>> call(EmployeeParams params) =>
      myTimeOffRepository.myTimeOff(params);
}

class AllTimeOffUsecase implements UseCase<MyTimeOffEntity, NoParams> {
  final MyTimeOffRepository myTimeOffRepository;

  AllTimeOffUsecase(this.myTimeOffRepository);

  @override
  Future<Either<Failure, MyTimeOffEntity>> call(NoParams params) =>
      myTimeOffRepository.allTimeOff(params);
}
