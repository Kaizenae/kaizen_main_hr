import '../../domain/entities/get_currency_entity.dart';

class GetCurrencyModel extends GetCurrencyEntity {
  GetCurrencyModel({
    ResultEntity? resultEntity,
  }) : super(resultEntity: resultEntity!);

  factory GetCurrencyModel.fromJson(Map<String, dynamic> json) =>
      GetCurrencyModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    int? status,
    String? message,
    List<ResponseEntity>? response,
  }) : super(
            status: status ?? 400,
            message: message ?? '',
            response: response ?? []);

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['message'],
        response: List<ResponseEntity>.from(
            json['response'].map((e) => ResponseModel.fromJson(e))),
      );

  Map<String, dynamic> toJson() => {
        "success": status,
        "message": message,
        "response": response,
      };
}

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    int? id,
    String? name,
    String? symbol,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          symbol: symbol ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
      };
}
