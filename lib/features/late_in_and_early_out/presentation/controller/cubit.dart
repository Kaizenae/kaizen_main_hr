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
  static EarlyOutLateInCubit get(context) => BlocProvider.of(context);

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
      emit(EarlyOutSuccessState(
          message: value.data["result"]["message"].toString()));
    }).catchError((error) {
      emit(EarlyOutErrorState(
          message: "Some thing went wrong, Try again later!!"));
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
      emit(LateInSuccessState(
          message: value.data["result"]["message"].toString()));
    }).catchError((error) {
      emit(LateInErrorState(
          message: "Some thing went wrong, Try again later!!"));
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

  List lateInPending = [];
  List lateInRefuse = [];
  List lateInDone = [];
  LateinEarlyOutModel lateinModel = LateinEarlyOutModel();
  void getLateIn() {
    lateInPending = [];
    lateInRefuse = [];
    lateInDone = [];
    emit(GetLateInEarlyOutLoadingState());
    Dio().get(EndPoints.getLateInPath, data: {
      "jsonrpc": "2.0",
      "params": {
        "company_id": AppConstants.companyId,
        "user_id": CacheHelper.get(key: AppConstants.userId),
      }
    }).then((value) {
      lateinModel = LateinEarlyOutModel.fromJson(value.data);
      for (var element in lateinModel.result.responseModel) {
        if (element.state == "submitted") {
          lateInPending.add(element);
        } else if (element.state == 'done') {
          lateInDone.add(element);
        } else {
          lateInRefuse.add(element);
        }
      }
      emit(GetLateInSuccessState());
    }).catchError((error) {
      emit(GetLateInErrorState());
    });
  }

  List earlyOutPending = [];
  List earlyOutRefuse = [];
  List earlyOutDone = [];

  LateinEarlyOutModel earlyOutModel = LateinEarlyOutModel();
  void getEarlyOut() {
    earlyOutPending = [];
    earlyOutRefuse = [];
    earlyOutDone = [];
    emit(GetLateInEarlyOutLoadingState());
    Dio().get(EndPoints.getEarlyOutPath, data: {
      "jsonrpc": "2.0",
      "params": {
        "company_id": AppConstants.companyId,
        "user_id": CacheHelper.get(key: AppConstants.userId),
      }
    }).then((value) {
      earlyOutModel = LateinEarlyOutModel.fromJson(value.data);
      for (var element in earlyOutModel.result.responseModel) {
        if (element.state == "submitted") {
          earlyOutPending.add(element);
        } else if (element.state == 'done') {
          earlyOutDone.add(element);
        } else {
          earlyOutRefuse.add(element);
        }
      }
      emit(GetEarlyOutSuccessState());
    }).catchError((error) {
      emit(GetEarlyOutErrorState());
    });
  }
}
