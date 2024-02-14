// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../domain/entities/myTimeOff_entity.dart';
import '../../domain/usecases/myTimeOff_usecase.dart';
import 'myTimeOff_state.dart';

class MyTimeOffCubit extends Cubit<MyTimeOffState> {
  final MyTimeOffUsecase myTimeOffUsecase;
  final AllTimeOffUsecase allTimeOffUsecase;

  MyTimeOffCubit(
      {required this.myTimeOffUsecase, required this.allTimeOffUsecase})
      : super(MyTimeOffInitial());

  static MyTimeOffCubit get(context) => BlocProvider.of(context);
  dynamic userId;
  List<ResponseEntity> myTimeOffPending = [];
  List<ResponseEntity> myTimeOffRefuse = [];
  List<ResponseEntity> myTimeOff = [];

  Future<void> getMyTimeOffFun() async {
    emit(GetMyTimeOffLoading());
    myTimeOffPending = [];
    myTimeOffRefuse = [];
    myTimeOff = [];
    Either<Failure, MyTimeOffEntity> response = await myTimeOffUsecase(
        EmployeeParams(userId: userId ?? AppConstants.token));

    emit(response.fold((failure) {
      userId = null;
      return GetMyTimeOffError(message: failure.message);
    }, (myTimeOffEntity) {
      for (var element in myTimeOffEntity.resultEntity.response) {
        if (element.state == 'confirm') {
          myTimeOffPending.add(element);
        } else if (element.state == 'validate') {
          myTimeOff.add(element);
        } else {
          myTimeOffRefuse.add(element);
        }
      }
      userId = null;
      return GetMyTimeOffSuccess(myTimeOffEntity: myTimeOffEntity);
    }));
  }

  Future<void> getAllTimeOffFun() async {
    emit(GetMyTimeOffLoading());
    myTimeOffPending = [];
    myTimeOffRefuse = [];
    myTimeOff = [];
    Either<Failure, MyTimeOffEntity> response =
        await allTimeOffUsecase(NoParams());

    emit(response.fold((failure) {
      return GetMyTimeOffError(message: failure.message);
    }, (myTimeOffEntity) {
      for (var element in myTimeOffEntity.resultEntity.response) {
        if (element.state == 'confirm') {
          myTimeOffPending.add(element);
        } else if (element.state == 'validate') {
          myTimeOff.add(element);
        } else {
          myTimeOffRefuse.add(element);
        }
      }
      return GetMyTimeOffSuccess(myTimeOffEntity: myTimeOffEntity);
    }));
  }
}
