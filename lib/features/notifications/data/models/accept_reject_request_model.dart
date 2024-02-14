import '../../domain/entities/accept_reject_request_entity.dart';

class AcceptRejectRequestModel extends AcceptRejectRequestEntity {
  AcceptRejectRequestModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory AcceptRejectRequestModel.fromJson(Map<String, dynamic> json) =>
      AcceptRejectRequestModel(
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
        status: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'success': status,
        'message': message,
      };
}
