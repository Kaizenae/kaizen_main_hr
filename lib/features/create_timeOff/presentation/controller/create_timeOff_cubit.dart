// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:Attendace/core/usecases/usecase.dart';
import 'package:Attendace/core/utils/constants_manager.dart';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

  String? selectedStartDateShow =
      DateFormat("dd,MMM,yyyy").format(DateTime.now());
  String? selectedEndDateShow =
      DateFormat("dd,MMM,yyyy").format(DateTime.now());
  String? selectedStartDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? selectedEndDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String checkType = '';
  int selectedValue = 0;

  String dateCount = '';
  String range = '';
  String rangeCount = '';
  getTimeOff(String currency) {
    emit(TimeOffLoading());
    checkType = currency;
    emit(TimeOffSuccess());
  }

  DateTime initDate = DateTime.now();

  void changeStartDate({required String date, required DateTime dateTime}) {
    selectedStartDateShow = date;
    initDate = dateTime;
    log(selectedStartDateShow.toString());

    emit(ChangeStartDateState());
  }

  void changeEndDate({required String date, required DateTime dateTime}) {
    selectedEndDateShow = date;
    initDate = dateTime;
    log(selectedEndDateShow.toString());

    emit(ChangeEndDateState());
  }

  Future<void> createTimeOffFun({required String reason}) async {
    emit(CreateTimeOffLoading());
    Either<Failure, CreateTimeOffEntity> response =
        await createTimeOffUsecase(CreateTimeOffParams(
      startDate: selectedStartDate!.toString(),
      endDate: selectedEndDate!.toString(),
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
