// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class CreateTimeOffEntity extends Equatable {
  final ResultEntity resultEntity;

  const CreateTimeOffEntity({
    required this.resultEntity,
  });

  @override
  List<Object?> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final int status;
  final String message;

  const ResultEntity({
    required this.status,
    required this.message,
  });

  @override
  List<Object?> get props => [status, message];
}
