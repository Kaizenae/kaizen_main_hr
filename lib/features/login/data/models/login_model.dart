import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({ResultEntity? resultEntity})
      : super(
          resultEntity: resultEntity!,
        );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {"result": resultEntity};
}

class ResultModel extends ResultEntity {
  ResultModel(
      {bool? status,
      bool? admin,
      List<String>? message,
      int? id,
      int? companyId,
      bool? loginBefore})
      : super(
          status: status ?? false,
          message: message ?? [],
          id: id ?? 0,
          companyId: companyId ?? 0,
          admin: admin ?? false,
          loginBefore: loginBefore ?? false,
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
      status: json['status'],
      admin: json['admin'],
      id: json['id'],
      loginBefore: json["login_before"],
      companyId: json['company_id'],
      message: json['message'].cast<String>());

  Map<String, dynamic> toJson() => {
        "success": status,
        "message": message,
        "id": id,
        "login_before": loginBefore
      };
}
