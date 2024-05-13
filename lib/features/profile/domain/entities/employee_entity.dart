import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final ResultEntity resultEntity;

  const EmployeeEntity({required this.resultEntity});

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
  final int companyId;
  final String name;
  final String mobilePhone;
  final String email;
  final String gender;
  final bool isAdmin;
  final String birthday;
  final String companyName;
  final String noId;
  final String salary;
  final String photo;

  const ResponseEntity(
      {required this.id,
      required this.name,
      required this.mobilePhone,
      required this.gender,
      required this.companyId,
      required this.companyName,
      required this.isAdmin,
      required this.email,
      required this.noId,
      required this.salary,
      required this.photo,
      required this.birthday});

  @override
  List<Object> get props => [
        id,
        companyId,
        name,
        mobilePhone,
        email,
        gender,
        birthday,
        companyName,
        photo,
      ];
}
