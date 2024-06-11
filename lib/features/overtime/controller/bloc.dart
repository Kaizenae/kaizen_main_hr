import 'package:Attendace/core/api/end_points.dart';
import 'package:Attendace/core/local/cache_helper.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/features/overtime/controller/states.dart';
import 'package:Attendace/features/overtime/model/overtime_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/constants_manager.dart';

class OvertimeBloc extends Cubit<OvertimeStates> {
  OvertimeBloc() : super(OvertimeInitState());
  static OvertimeBloc get(context) => BlocProvider.of(context);
  String? selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? selectedFromTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String? selectedToTime = DateFormat("HH:mm:ss").format(DateTime.now());
  void changeDate(String date) {
    selectedDate = date;

    emit(ChangeDateState());
  }

  void createOvertime({
    required String description,
  }) {
    emit(GetOvertimeLoadingState());
    Dio().post(EndPoints.createOvertimePath, data: {
      "params": {
        "user_id": int.parse(CacheHelper.get(key: AppConstants.userId)),
        "date": selectedDate,
        "from": selectedFromTime,
        "to": selectedToTime,
        "description": description
      }
    }).then((value) {
      emit(CreateOvertimeSuccessState(
          message: value.data["result"]["response"]));
    }).catchError((error) {
      emit(
        CreateOvertimeErrorState(
            message: AppStrings.someThingWentWrongTryAgainLater),
      );
    });
  }

  List<ResponseModel> peindingOvertime = [];
  List<ResponseModel> approvedOvertime = [];
  List<ResponseModel> rejectOvertime = [];
  OvertimeModel overtimeModel = OvertimeModel();
  void getOvertime() {
    emit(GetOvertimeLoadingState());
    peindingOvertime = [];
    rejectOvertime = [];
    approvedOvertime = [];
    Dio().get(EndPoints.getOvertimePath, data: {
      "params": {
        "user_id": int.parse(CacheHelper.get(key: AppConstants.userId)),
      }
    }).then((value) {
      overtimeModel = OvertimeModel.fromJson(value.data);
      for (var item in overtimeModel.result.responseModel) {
        if (item.state == "cancelled") {
          rejectOvertime.add(item);
        } else if (item.state == "ceo_approved") {
          approvedOvertime.add(item);
        } else {
          peindingOvertime.add(item);
        }
      }
      emit(GetOvertimeSuccessState());
    }).catchError((error) {
      emit(GetOvertimeErrorState());
    });
  }

  void cancelMyRequest({
    required int requestId,
  }) {
    emit(CancelMyRequestLoadingState());
    Dio().post(EndPoints.cancelMyRequestPath, data: {
      "jsonrpc": 2.0,
      "params": {
        "request_id": requestId,
        "type": "Overtime",
        "reason": "",
      }
    }).then((value) {
      emit(CancelMyRequestSuccessState(
          message: value.data["result"]["response"]));
      getOvertime();
    }).catchError((error) {
      emit(CancelMyRequestErrorState(
          message: AppStrings.someThingWentWrongTryAgainLater));
    });
  }
}
