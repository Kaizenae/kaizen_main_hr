import '../../domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
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
    int? companyId,
    String? companyName,
    String? mobilePhone,
    String? gender,
    String? email,
    bool? isAdmin,
    String? birthday,
    String? noId,
    String? salary,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          companyId: companyId ?? 0,
          companyName: companyName ?? '',
          email: email ?? '',
          birthday: birthday ?? '',
          gender: gender ?? '',
          isAdmin: isAdmin ?? false,
          mobilePhone: mobilePhone ?? '',
          salary: salary ?? '',
          noId: noId ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        id: json['id'],
        mobilePhone: json['work_phone'],
        email: json['work_email'],
        gender: json['gender'],
        birthday: json['birthday'],
        isAdmin: json['is_admin'],
        companyId: json['company_id'],
        companyName: json['work_place'],
        salary: json['wage'].toString(),
        noId: json['notification_id'] == false ? '' : json['notification_id'],
      );
}
