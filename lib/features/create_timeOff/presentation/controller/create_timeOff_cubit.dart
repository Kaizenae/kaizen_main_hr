// ignore_for_file: file_names

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
  TextEditingController daysController = TextEditingController();
  DateRangePickerController dateController = DateRangePickerController();
  String dateFormate = "MM/dd/yyyy";
  String? selectedDate = DateFormat("MM/dd/yyyy").format(DateTime.now());
  String checkType = '';
  int selectedValue = 0;
  String? selectDate;

  String dateCount = '';
  String range = '';
  String rangeCount = '';
  getTimeOff(String currency) {
    emit(TimeOffLoading());
    checkType = currency;
    emit(TimeOffSuccess());
  }

  onSelectionChanged({required DateRangePickerSelectionChangedArgs args}) {
<<<<<<< HEAD
    selectDate = DateFormat("EEE").format(args.value).toString();
=======
    selectDate = DateFormat("MM/dd/yyyy").format(args.value).toString();
>>>>>>> main
    if (args.value is PickerDateRange) {
      range = '${DateFormat('MM/dd/yyyy').format(args.value.startDate)} -'
          // ignore: lineslonger_than_80_chars
          ' ${DateFormat('MM/dd/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
<<<<<<< HEAD
      selectedDate = args.value.toString();
=======
      selectedDate = DateFormat("MM/dd/yyyy").format(args.value).toString();

>>>>>>> main
      emit(ChangeSelectedDateState());
    } else if (args.value is List<DateTime>) {
      dateCount = args.value.length.toString();
    } else {
      rangeCount = args.value.length.toString();
    }
  }

  Future<void> createTimeOffFun() async {
    emit(CreateTimeOffLoading());
    Either<Failure, CreateTimeOffEntity> response =
        await createTimeOffUsecase(CreateTimeOffParams(
      date: selectedDate!,
      days: int.parse(daysController.text),
      userId: AppConstants.token,
      holidayStatus: selectedValue,
    ));

    emit(response.fold((failure) {
      return CreateTimeOffError(message: failure.message);
    }, (createTimeOffEntity) {
      return CreateTimeOffSuccess(createTimeOffEntity: createTimeOffEntity);
    }));
  }

  String? fileName;
  pickFileFromDevice() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    }
    final file = result.files.first;
    fileName = file.name;
    emit(ChangeFileNameState());
  }
}
