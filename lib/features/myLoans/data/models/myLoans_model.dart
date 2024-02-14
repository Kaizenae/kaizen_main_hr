// ignore_for_file: file_names

import '../../domain/entities/myLoans_entity.dart';

class MyLoansModel extends MyLoansEntity {
  MyLoansModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory MyLoansModel.fromJson(Map<String, dynamic> json) => MyLoansModel(
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
    String? employeeId,
    double? loanAmount,
    String? loanState,
    String? currencyId,
    String? loanDate,
  }) : super(
          id: id ?? 0,
          employeeId: employeeId ?? '',
          loanAmount: loanAmount ?? 0.0,
          loanState: loanState ?? '',
          currencyId: currencyId ?? '',
          loanDate: loanDate ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        id: json['id'],
        employeeId: json['employee_id'],
        loanAmount: json['loan_amount'],
        loanState: json['loan_state'],
        currencyId: json['currency_id'],
        loanDate: json['loan_date'],
      );
}
