// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class MyRequestsEntity extends Equatable {
  final ResultEntity resultEntity;

  const MyRequestsEntity({required this.resultEntity});

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
  final int employeeId;
  final String employeeName;
  final String message;
  final String date;
  final String distance;
  final String location;
  final String noId;
  final String state;
  final bool isAccept;
  final String checkType;

  const ResponseEntity({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.message,
    required this.date,
    required this.distance,
    required this.location,
    required this.state,
    required this.noId,
    required this.isAccept,
    required this.checkType,
  });

  @override
  List<Object> get props => [
        id,
        employeeId,
        employeeName,
        message,
        date,
        distance,
        location,
        state,
        isAccept,
        checkType,
      ];
}
