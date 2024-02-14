// ignore_for_file: file_names

import '../../domain/entities/punchInOut_entity.dart';

class PunchInOutModel extends PunchInOutEntity {
  PunchInOutModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory PunchInOutModel.fromJson(Map<String, dynamic> json) =>
      PunchInOutModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  const ResultModel({
    bool? status,
    String? message,
  }) : super(
          status: status ?? false,
          message: message ?? '',
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['message'],
      );
}
