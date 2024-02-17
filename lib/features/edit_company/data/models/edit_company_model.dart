import '../../domain/entities/edit_company_entity.dart';

class EditCompanyModel extends EditCompanyEntity {
  EditCompanyModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory EditCompanyModel.fromJson(Map<String, dynamic> json) =>
      EditCompanyModel(
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
