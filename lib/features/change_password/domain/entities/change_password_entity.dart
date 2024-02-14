import 'package:equatable/equatable.dart';

class ChangePasswordEntity extends Equatable {
  final ResultEntity resultEntity;

  const ChangePasswordEntity({
    required this.resultEntity,
  });

  @override
  List<Object?> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final List<String> message;

  const ResultEntity({
    required this.status,
    required this.message,
  });

  @override
  List<Object> get props => [
        status,
        message,
      ];
}
