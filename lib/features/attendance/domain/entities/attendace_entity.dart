import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final ResultEntity resultEntity;

  const AttendanceEntity({required this.resultEntity});

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
  final String name;
  final String checkIn;
  final String checkOut;
  final double workedHours;

  const ResponseEntity({
    required this.id,
    required this.name,
    required this.checkIn,
    required this.checkOut,
    required this.workedHours,
  });

  @override
  List<Object> get props => [id, name, checkIn, checkOut, workedHours];
}
