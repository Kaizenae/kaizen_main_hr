import '../../domain/entities/create_loan_entity.dart';

class CreateLoanModel extends CreateLoanEntity {
  CreateLoanModel({
    ResultEntity? resultEntity,
  }) : super(resultEntity: resultEntity!);

  factory CreateLoanModel.fromJson(Map<String, dynamic> json) =>
      CreateLoanModel(
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
        "status": status,
        "message": message,
      };
}
