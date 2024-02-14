import 'package:equatable/equatable.dart';

class CompaniesEntity extends Equatable {
  final ResultEntity resultEntity;

  const CompaniesEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final int status;
  final List<ResponseEntity> response;

  const ResultEntity({required this.status, required this.response});

  @override
  List<Object> get props => [status, response];
}

class ResponseEntity extends Equatable {
  final int id;
  final String name;
  final String lat;
  final String long;

  const ResponseEntity({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
  });

  @override
  List<Object> get props => [id, name, lat, long];
}
