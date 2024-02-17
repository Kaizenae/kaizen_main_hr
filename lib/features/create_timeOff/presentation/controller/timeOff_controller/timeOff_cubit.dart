// ignore_for_file: file_names

import 'package:Attendace/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/get_TimeOff_entity.dart';
import '../../../domain/usecases/create_timeOff_usecase.dart';
import 'timeOff_state.dart';

class TimeOffCubit extends Cubit<TimeOffState> {
  final GetTimeOffUsecase getTimeOffUsecase;

  TimeOffCubit({required this.getTimeOffUsecase}) : super(TimeOffInitial());

  static TimeOffCubit get(context) => BlocProvider.of(context);

  Future<void> getTimeOffFun() async {
    emit(GetTimeOffLoading());
    Either<Failure, GetTimeOffEntity> response =
        await getTimeOffUsecase(NoParams());

    emit(response.fold((failure) {
      return GetTimeOffError(message: failure.message);
    }, (getTimeOffEntity) {
      return GetTimeOffSuccess(getTimeOffEntity: getTimeOffEntity);
    }));
  }
}
