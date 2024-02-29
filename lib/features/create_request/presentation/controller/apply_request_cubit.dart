import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:Attendace/features/create_request/domain/entities/apply_request_entity.dart';
import 'package:Attendace/features/create_request/domain/usecases/apply_request_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'dart:math' as math;

import '../../../../core/error/failure.dart';
import 'apply_request_state.dart';

class ApplyRequestCubit extends Cubit<ApplyRequestState> {
  final ApplyRequestUsecase applyRequestUsecase;

  ApplyRequestCubit({required this.applyRequestUsecase})
      : super(ApplyRequestInitial());

  static ApplyRequestCubit get(context) => BlocProvider.of(context);

  Location location = Location();
  bool serviceEnabled = false;
  PermissionStatus? permissionGranted;
  LocationData? locationData;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController messageController = TextEditingController();
  String checkType = '';
  String selectedValue = '';

  void typeFun(String value) {
    emit(CheckTypeStateLoading());

//  checkType =  switch (value) {
//   'Punch in' => 'check_in',
//   'Punch out' => 'check_out',
//   'Holiday' => 'holiday',
//   'Leave Request' => 'leave_of_request',
//   _ => 'check_in', //Default value
// };

    if (value == 'Punch in') {
      checkType = 'check_in';
      selectedValue = value;
    } else if (value == 'Punch out') {
      checkType = 'check_out';
      selectedValue = value;
    } else if (value == 'Holiday') {
      checkType = 'holiday';
      selectedValue = value;
    } else if (value == 'Leave Request') {
      checkType = 'leave_of_request';
      selectedValue = value;
    }
    emit(CheckTypeStateSuccess());
  }

  List<double> companyLocation = [29.982704, 31.306464];

  getDistanceFromLatLonInMeter() async {
    await getLocationData();
    var R = 6371000; // Radius of the earth in km

    var dLat = deg2rad(companyLocation[0] -
        locationData!.latitude!.toDouble()); // deg2rad below

    var dLon =
        deg2rad(companyLocation[1] - locationData!.longitude!.toDouble());

    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(companyLocation[0])) *
            math.cos(deg2rad(locationData!.latitude!.toDouble())) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km

    debugPrint("Distance => ${d.toInt()}");

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

    debugPrint(locationData.toString());
  }

  Future<void> applyRequest() async {
    var distance = await getDistanceFromLatLonInMeter();

    emit(ApplyRequestLoading());
    Either<Failure, ApplyRequestEntity> response = await applyRequestUsecase(
        ApplyRequestParams(
            message: messageController.text,
            date: DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
            distance: distance.toString(),
            userId: AppConstants.token,
            location:
                "https://www.google.com/maps/search/?api=1&query=${locationData!.latitude},${locationData!.longitude}",
            check_type: checkType));

    emit(response.fold((failure) {
      formKey.currentState?.reset();
      return ApplyRequestError(message: failure.message);
    }, (applyRequestEntity) {
      formKey.currentState?.reset();
      return ApplyRequestSuccess(applyRequestEntity: applyRequestEntity);
    }));
  }
}
