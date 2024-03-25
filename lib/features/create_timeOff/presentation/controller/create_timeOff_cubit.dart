// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/core/utils/constants_manager.dart';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/create_timeOff_entity.dart';
import '../../domain/usecases/create_timeOff_usecase.dart';
import 'create_timeOff_state.dart';

class CreateTimeOffCubit extends Cubit<CreateTimeOffState> {
  final CreateTimeOffUsecase createTimeOffUsecase;

  CreateTimeOffCubit({required this.createTimeOffUsecase})
      : super(CreateTimeOffInitial());

  static CreateTimeOffCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  DateRangePickerController endDateController = DateRangePickerController();
  DateRangePickerController startDateController = DateRangePickerController();
  String dateFormate = "yyyy-MM-dd";
  String? selectedStartDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? selectedEndDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String checkType = '';
  int selectedValue = 0;
  String? selectStartDate;
  String? selectEndDate;

  String dateCount = '';
  String range = '';
  String rangeCount = '';
  getTimeOff(String currency) {
    emit(TimeOffLoading());
    checkType = currency;
    emit(TimeOffSuccess());
  }

  onSelectionStartDateChanged(
      {required DateRangePickerSelectionChangedArgs args}) {
    selectStartDate = DateFormat("yyyy-MM-dd").format(args.value).toString();
    if (args.value is PickerDateRange) {
      range = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)} -'
          // ignore: lineslonger_than_80_chars
          ' ${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      selectedStartDate =
          DateFormat("yyyy-MM-dd").format(args.value).toString();
    } else if (args.value is List<DateTime>) {
      dateCount = args.value.length.toString();
    } else {
      rangeCount = args.value.length.toString();
    }
    emit(ChangeSelectedStartDateState());
  }

  onSelectionEndDateChanged(
      {required DateRangePickerSelectionChangedArgs args}) {
    selectEndDate = DateFormat("yyyy-MM-dd").format(args.value).toString();
    if (args.value is PickerDateRange) {
      range = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)} -'
          // ignore: lineslonger_than_80_chars
          ' ${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      selectedEndDate = DateFormat("yyyy-MM-dd").format(args.value).toString();
    } else if (args.value is List<DateTime>) {
      dateCount = args.value.length.toString();
    } else {
      rangeCount = args.value.length.toString();
    }
    emit(ChangeSelectedEndDateState());
  }

  Future<void> createTimeOffFun({required String reason}) async {
    emit(CreateTimeOffLoading());
    Either<Failure, CreateTimeOffEntity> response =
        await createTimeOffUsecase(CreateTimeOffParams(
      startDate: selectedStartDate!,
      endDate: selectedEndDate!,
      reason: reason,
      userId: AppConstants.token,
      holidayStatus: selectedValue,
      attachment: base64string,
    ));

    emit(response.fold((failure) {
      return CreateTimeOffError(message: failure.message);
    }, (createTimeOffEntity) {
      return CreateTimeOffSuccess(createTimeOffEntity: createTimeOffEntity);
    }));
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
}
