import 'package:Attendace/core/api/end_points.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/features/check-in_check-out/model/location_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../../../core/local/cache_helper.dart';
import '../../../core/services/location_services.dart';
import '../../../core/utils/constants_manager.dart';
import 'states.dart';

class CheckInCheckOutBloc extends Cubit<CheckInCheckOutStates> {
  CheckInCheckOutBloc() : super(CheckInCheckOutInitState());
  static CheckInCheckOutBloc get(context) => BlocProvider.of(context);

  getDistanceFromLatLonInMeter({required latitude, required longitude}) async {
    await LocationServices.getCurrentLocation();
    var R = 6371000; // Radius of the earth in km

    var dLat = deg2rad(lat - latitude!.toDouble()); // deg2rad below

    var dLon = deg2rad(long - longitude!.toDouble());

    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(lat)) *
            math.cos(deg2rad(latitude!.toDouble())) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d.toInt();
  }

  List<double> companyLocation = [];
  double lat = 0.0;
  double long = 0.0;
  deg2rad(deg) {
    return deg * (math.pi / 180);
  }

  var currentTime = DateFormat.jm('en_US').format(DateTime.now()).toString();
  var currentDate = DateFormat.yMd('en_US').format(DateTime.now()).toString();

  void checkInCheckOut() {
    emit(CheckInCheckOutLoadingState());
    Dio().post(
      EndPoints.checkInCheckOutPath,
      data: {
        "jsonrpc": "2.0",
        "params": {
          "user_id": int.parse(CacheHelper.get(key: AppConstants.userId)),
        }
      },
    ).then((value) {
      emit(CheckInCheckOutSuccessState(
          message: value.data["result"]["message"]));
    }).catchError((error) {
      emit(
        CheckInCheckOutErrorState(
          message: AppStrings.someThingWentWrongTryAgainLater,
        ),
      );
    });
  }

  bool checked = false;

  Future<void> checkDistance({required latitude, required longitude}) async {
    if (await getDistanceFromLatLonInMeter(
            latitude: latitude, longitude: longitude) <=
        250) {
      checked = true;
    } else {
      checked = false;
    }
  }

  LocationModel locationModel = LocationModel();

  void getCompanyLocation() {
    emit(GetCompanyLocationLoadingState());
    Dio().get(EndPoints.getlocationPath, data: {
      "params": {
        "user_id": int.parse(CacheHelper.get(key: AppConstants.userId)),
      }
    }).then((value) {
      locationModel = LocationModel.fromJson(value.data);
      lat = locationModel.result.responseModel.latitude.toDouble();
      long = locationModel.result.responseModel.longitude.toDouble();
      emit(GetCompanyLocationSuccessState());
    }).catchError((error) {
      emit(GetCompanyLocationErrorState());
    });
  }
}
