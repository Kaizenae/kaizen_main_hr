// ignore_for_file: file_names

import '../../domain/entities/create_timeOff_entity.dart';

class CreateTimeOffModel extends CreateTimeOffEntity {
  CreateTimeOffModel({
    ResultEntity? resultEntity,
  }) : super(resultEntity: resultEntity!);

  factory CreateTimeOffModel.fromJson(Map<String, dynamic> json) =>
      CreateTimeOffModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  const ResultModel({
    int? status,
    String? message,
  }) : super(status: status ?? 400, message: message ?? '');

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      ResultModel(status: json['status'], message: json['message']);

  Map<String, dynamic> toJson() => {
        "success": status,
        "message": message,
      };
}
