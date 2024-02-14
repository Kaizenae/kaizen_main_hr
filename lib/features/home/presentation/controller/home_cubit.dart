import 'dart:math' as math;
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../domain/entities/punchInOut_entity.dart';
import '../../domain/usecases/punchInOut_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PunchInOutUsecase punchInOutUsecase;
  HomeCubit({required this.punchInOutUsecase}) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  Future<void> punchInOutFun() async {
    emit(CheckInAndOutLoading());

    Either<Failure, PunchInOutEntity> response =
        await punchInOutUsecase(EmployeeParams(userId: AppConstants.token));

    emit(response.fold(
        (failure) => CheckInAndOutError(message: failure.message),
        (punchInOutEntity) =>
            CheckInAndOutSuccess(punchInOutEntity: punchInOutEntity)));
  }

  Location location = Location();
  bool serviceEnabled = false;
  PermissionStatus? permissionGranted;
  LocationData? locationData;
  TextEditingController messageController = TextEditingController();

  List<double> companyLocation = [];
  double lat = 0.0;
  double long = 0.0;

  getDistanceFromLatLonInMeter() async {
    await getLocationData();
    var R = 6371000; // Radius of the earth in km

    var dLat =
        deg2rad(lat - locationData!.latitude!.toDouble()); // deg2rad below

    var dLon = deg2rad(long - locationData!.longitude!.toDouble());

    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(lat)) *
            math.cos(deg2rad(locationData!.latitude!.toDouble())) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km
    if (kDebugMode) {
      print("Distance => ${d.toInt()}");
    }
    return d.toInt();
  }

  deg2rad(deg) {
    return deg * (math.pi / 180);
  }

  Future<void> getLocationData() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    if (kDebugMode) {
      print(locationData);
    }
  }

  var currentTime = DateFormat.jm('en_US').format(DateTime.now()).toString();
  var currentDate = DateFormat.yMd('en_US').format(DateTime.now()).toString();
  bool checked = false;

  Future<void> checkDistance() async {
    if (await getDistanceFromLatLonInMeter() <= 20) {
      checked = true;
    } else {
      checked = false;
    }
  }

  bool flag = false;

  isPunchedFun() async {
    emit(PunchChangeLoading());

    await CacheHelper.put(
        key: AppStrings.punched, value: !(AppConstants.isPunched));
    AppConstants.isPunched = await CacheHelper.get(key: AppStrings.punched);
    flag = AppConstants.isPunched;

    emit(PunchChange());
  }
}
