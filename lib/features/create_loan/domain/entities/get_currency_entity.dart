import 'package:equatable/equatable.dart';

class GetCurrencyEntity extends Equatable {
  final ResultEntity resultEntity;

  const GetCurrencyEntity({
    required this.resultEntity,
  });

  @override
  List<Object?> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final int status;
  final String message;
  final List<ResponseEntity> response;

  const ResultEntity({
    required this.status,
    required this.message,
    required this.response,
  });

  @override
  List<Object> get props => [status, message, response];
}

class ResponseEntity extends Equatable {
  final int id;
  final String name;
  final String symbol;

  const ResponseEntity({
    required this.id,
    required this.name,
    required this.symbol,
  });

  @override
  List<Object> get props => [id, name, symbol];
}
