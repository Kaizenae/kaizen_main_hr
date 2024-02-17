import 'package:equatable/equatable.dart';

class AcceptRejectRequestEntity extends Equatable {
  final ResultEntity resultEntity;

  const AcceptRejectRequestEntity({
    required this.resultEntity,
  });

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;

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
