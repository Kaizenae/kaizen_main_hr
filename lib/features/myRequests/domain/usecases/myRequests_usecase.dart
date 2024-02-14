// ignore_for_file: file_names

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/myRequests_entity.dart';
import '../repositories/myRequests_repository.dart';

class MyRequestsUsecase implements UseCase<MyRequestsEntity, EmployeeParams> {
  final MyRequestsRepository myRequestsRepository;

  MyRequestsUsecase(this.myRequestsRepository);

  @override
  Future<Either<Failure, MyRequestsEntity>> call(EmployeeParams params) =>
      myRequestsRepository.myRequests(params);
}

class MyRequestsPendingUsecase
    implements UseCase<MyRequestsEntity, EmployeeParams> {
  final MyRequestsRepository myRequestsRepository;

  MyRequestsPendingUsecase(this.myRequestsRepository);

  @override
  Future<Either<Failure, MyRequestsEntity>> call(EmployeeParams params) =>
      myRequestsRepository.myRequestsPending(params);
}
