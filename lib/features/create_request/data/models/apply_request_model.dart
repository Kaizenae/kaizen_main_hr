import '../../domain/entities/apply_request_entity.dart';

class ApplyRequestModel extends ApplyRequestEntity {
  ApplyRequestModel({
    ResultEntity? resultEntity,
  }) : super(resultEntity: resultEntity!);

  factory ApplyRequestModel.fromJson(Map<String, dynamic> json) =>
      ApplyRequestModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  const ResultModel({
    bool? status,
    String? message,
  }) : super(status: status ?? false, message: message ?? '');

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      ResultModel(status: json['success'], message: json['message']);

  Map<String, dynamic> toJson() => {
        "success": status,
        "message": message,
      };
}
