import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final ResultEntity resultEntity;

  const LoginEntity({
    required this.resultEntity,
  });

  @override
  List<Object?> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final bool admin;
  final List<String> message;
  final int id;
  final int companyId;

  const ResultEntity({
    required this.status,
    required this.message,
    required this.id,
    required this.admin,
    required this.companyId,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        id,
      ];
}
