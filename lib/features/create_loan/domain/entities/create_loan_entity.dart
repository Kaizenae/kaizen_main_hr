import 'package:equatable/equatable.dart';

class CreateLoanEntity extends Equatable {
  final ResultEntity resultEntity;

  const CreateLoanEntity({
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
