import '../../domain/entities/companies_entity.dart';

class CompaniesModel extends CompaniesEntity {
  CompaniesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory CompaniesModel.fromJson(Map<String, dynamic> json) => CompaniesModel(
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
    String? lat,
    String? long,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          lat: lat ?? '',
          long: long ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['company_name'],
        id: json['company_id'],
        lat: json['lat'],
        long: json['long'],
      );
}
