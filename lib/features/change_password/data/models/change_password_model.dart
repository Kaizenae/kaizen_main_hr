import '../../domain/entities/change_password_entity.dart';

class ChangePasswordModel extends ChangePasswordEntity {
  ChangePasswordModel({ResultEntity? resultEntity})
      : super(
          resultEntity: resultEntity!,
        );

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {"result": resultEntity};
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    List<String>? message,
  }) : super(
          status: status ?? false,
          message: message ?? [],
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['message'].cast<String>(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
