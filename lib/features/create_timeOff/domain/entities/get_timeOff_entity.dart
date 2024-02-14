// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class GetTimeOffEntity extends Equatable {
  final ResultEntity resultEntity;

  const GetTimeOffEntity({
    required this.resultEntity,
  });

  @override
  List<Object?> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final int status;
  final String message;
  final List<ResponseEntity> response;

  const ResultEntity({
    required this.status,
    required this.message,
    required this.response,
  });

  @override
  List<Object> get props => [status, message, response];
}

class ResponseEntity extends Equatable {
  final int id;
  final String name;

  const ResponseEntity({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}
