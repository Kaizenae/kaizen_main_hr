// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:Attendace/core/api/end_points.dart';
import 'package:Attendace/features/late_in_and_early_out/presentation/controller/states.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../data/late_in_early_out_model.dart';

class EarlyOutLateInCubit extends Cubit<EarlyOutLateInStates> {
  EarlyOutLateInCubit() : super(EarlyOutLateInInitState());
  TextEditingController reasonController = TextEditingController();
  DateRangePickerController dateController = DateRangePickerController();
  String dateFormate = "MM/dd/yyyy";
  String? selectedDate = DateFormat("MM/dd/yyyy").format(DateTime.now());
  String checkType = '';
  int selectedValue = 0;
  String? selectDate;

  String dateCount = '';
  String range = '';
  String rangeCount = '';
  onSelectionChanged({required DateRangePickerSelectionChangedArgs args}) {
    selectDate = DateFormat("MM/dd/yyyy").format(args.value).toString();
    if (args.value is PickerDateRange) {
      range = '${DateFormat('MM/dd/yyyy').format(args.value.startDate)} -'
          // ignore: lineslonger_than_80_chars
          ' ${DateFormat('MM/dd/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      selectedDate = DateFormat("MM/dd/yyyy").format(args.value).toString();
    } else if (args.value is List<DateTime>) {
      dateCount = args.value.length.toString();
    } else {
      rangeCount = args.value.length.toString();
    }
    emit(ChangeSelectedDateState());
  }

  void earlyOutRequest() {
    emit(EarlyOutLoadingState());
    Dio().post(EndPoints.earlyOutPath, data: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": CacheHelper.get(key: AppConstants.userId).toString(),
        "company_id": AppConstants.companyId.toString().toString(),
        "reason": reasonController.text.toString(),
        "date": selectedDate.toString(),
        "attachment": base64string,
      }
    }).then((value) {
      emit(EarlyOutSuccessState(message: "Success"));
    }).catchError((error) {
      emit(EarlyOutErrorState(message: "Faild! You Return to the admin"));
    });
  }

  void lateIn() {
    emit(LateInLoadingState());
    Dio().post(EndPoints.lateInPath, data: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": CacheHelper.get(key: AppConstants.userId).toString(),
        "company_id": AppConstants.companyId.toString(),
        "reason": reasonController.text.toString(),
        "date": selectedDate.toString(),
        "attachment": base64string,
      }
    }).then((value) {
      emit(LateInSuccessState(message: "Success"));
    }).catchError((error) {
      emit(LateInErrorState(message: "Faild! You Return to the admin"));
    });
  }

  String? fileName;
  String base64string = "";
  File? filePath;

  pickFileFromDevice() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    } else {
      final file = result.files.first;
      filePath = File(result.paths.first!);
      fileName = file.name;
      Uint8List filebytes = await filePath!.readAsBytes(); //convert to bytes
      base64string = base64.encode(filebytes);
      emit(ChangeFileNameState());
    }
  }

  LateinEarlyOutModel lateinModel = LateinEarlyOutModel();
  void getLateIn() {
    emit(GetLateInEarlyOutLoadingState());
    Dio().get(EndPoints.getLateInPath, data: {
      "jsonrpc": "2.0",
      "params": {
        "company_id": AppConstants.companyId,
        "user_id": CacheHelper.get(key: AppConstants.userId),
      }
    }).then((value) {
      lateinModel = LateinEarlyOutModel.fromJson(value.data);
      emit(GetLateInSuccessState());
    }).catchError((error) {
      emit(GetLateInErrorState());
    });
  }

  LateinEarlyOutModel earlyOutModel = LateinEarlyOutModel();
  void getEarlyOut() {
    emit(GetLateInEarlyOutLoadingState());
    Dio().get(EndPoints.getEarlyOutPath, data: {
      "jsonrpc": "2.0",
      "params": {
        "company_id": AppConstants.companyId,
        "user_id": CacheHelper.get(key: AppConstants.userId),
      }
    }).then((value) {
      earlyOutModel = LateinEarlyOutModel.fromJson(value.data);
      emit(GetEarlyOutSuccessState());
    }).catchError((error) {
      emit(GetEarlyOutErrorState());
    });
  }
}
