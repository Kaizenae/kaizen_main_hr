import '../../domain/entities/employees_entity.dart';

class EmployeesModel extends EmployeesEntity {
  EmployeesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory EmployeesModel.fromJson(Map<String, dynamic> json) => EmployeesModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    int? status,
    List<ResponseEntity>? responseEntity,
  }) : super(
          status: status ?? 400,
          response: responseEntity ?? [],
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        responseEntity: List<ResponseEntity>.from(
            json['response'].map((e) => ResponseModel.fromJson(e))),
      );
}

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    int? id,
    String? name,
    int? mobilePhone,
    String? email,
    bool? isAdmin,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          email: email ?? '',
          isAdmin: isAdmin ?? false,
          mobilePhone: mobilePhone ?? 0,
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        id: json['id'],
        mobilePhone: json['phone_number'],
        email: json['login'],
        isAdmin: json['is_admin'],
      );
}
