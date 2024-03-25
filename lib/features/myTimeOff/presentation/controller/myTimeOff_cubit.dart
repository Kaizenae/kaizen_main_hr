// ignore_for_file: file_names

import 'package:Attendace/core/api/end_points.dart';
import 'package:Attendace/core/local/cache_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../data/models/all_time_off_value_model.dart';
import '../../data/models/time_off_type_model.dart';
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
      return GetMyTimeOffError(message: failure.message);
    }, (myTimeOffEntity) {
      for (var element in myTimeOffEntity.resultEntity.response) {
        if (element.state == 'Refused') {
          myTimeOffRefuse.add(element);
        } else if (element.state == 'Approved') {
          myTimeOff.add(element);
        } else {
          myTimeOffPending.add(element);
        }
      }
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

  AllTimeOffValueModel allTimeOffValueModel = AllTimeOffValueModel();
  void getAllTimeOffValues() {
    emit(GetTimeOffValueLoading());
    Dio().get(
      EndPoints.getAllTimeOffValuesPath,
      data: {
        "jsonrpc": "2.0",
        "params": {
          "user_id": CacheHelper.get(key: AppConstants.userId),
          "company_id": AppConstants.companyId,
        }
      },
    ).then((value) {
      allTimeOffValueModel = AllTimeOffValueModel.fromJson(value.data);

      emit(const GetTimeOffValueSuccess());
      getTimeOffValuesAndName();
    }).catchError((error) {
      emit(const GetTimeOffValueError());
    });
  }

  List<Map> allTimeOffNameAndValues = [];
  TimeOffTypeModel timeOffTypeModel = TimeOffTypeModel();
  void getTimeOffValuesAndName() {
    emit(const GetTimeOffNameAndValueLoading());
    Dio().get(EndPoints.getTimeOff, data: {
      "jsonrpc": "2.0",
      "params": {},
    }).then((value) {
      allTimeOffNameAndValues = [];
      timeOffTypeModel = TimeOffTypeModel.fromJson(value.data);
      for (var item in timeOffTypeModel.result.responseModel) {
        for (var element in allTimeOffValueModel.result.responseModel) {
          if (item.id == element.timeOffAllocation) {
            allTimeOffNameAndValues.add({
              "timeOffName": item.name,
              "timeOffValue":
                  element.timeOffAllocationRemainingValue.toString(),
            });
          }
        }
      }
      emit(const GetTimeOffNameAndValueSuccess());
    }).catchError((error) {
      emit(const GetTimeOffNameAndValueError());
    });
  }

  @override
  void onChange(Change<MyTimeOffState> change) {
    super.onChange(change);
  }
}
