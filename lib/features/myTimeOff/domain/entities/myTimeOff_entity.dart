// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class MyTimeOffEntity extends Equatable {
  final ResultEntity resultEntity;

  const MyTimeOffEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final int status;
  final List<ResponseEntity> response;

  const ResultEntity({required this.status, required this.response});

  @override
  List<Object> get props => [status, response];
}

class ResponseEntity extends Equatable {
  final int id;
  final String employeeName;
  final String holidayStatus;
  final String holidayType;
  final String state;
  final String start;
  final String end;
  final String description;

  const ResponseEntity({
    required this.id,
    required this.employeeName,
    required this.holidayStatus,
    required this.holidayType,
    required this.state,
    required this.start,
    required this.end,
    required this.description,
  });

  @override
  List<Object> get props => [
        id,
        employeeName,
        holidayStatus,
        holidayType,
        state,
        start,
        end,
      ];
}
