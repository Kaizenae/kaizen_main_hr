import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final ResultEntity resultEntity;

  const RegisterEntity({required this.resultEntity});

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
  List<Object?> get props => [status, message];
}
