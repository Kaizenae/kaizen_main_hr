import 'package:equatable/equatable.dart';

class EditCompanyEntity extends Equatable {
  final ResultEntity resultEntity;

  const EditCompanyEntity({
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
