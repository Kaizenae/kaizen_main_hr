import 'package:equatable/equatable.dart';

class EmployeesEntity extends Equatable {
  final ResultEntity resultEntity;

  const EmployeesEntity({required this.resultEntity});

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
  final int mobilePhone;
  final String email;
  final bool isAdmin;

  const ResponseEntity({
    required this.id,
    required this.name,
    required this.mobilePhone,
    required this.email,
    required this.isAdmin,
  });

  @override
  List<Object> get props => [id, name, mobilePhone];
}
