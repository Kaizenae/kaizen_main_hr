// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class MyLoansEntity extends Equatable {
  final ResultEntity resultEntity;

  const MyLoansEntity({required this.resultEntity});

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
  final String employeeId;
  final String loanDate;
  final double loanAmount;
  final String currencyId;
  final String loanState;

  const ResponseEntity({
    required this.id,
    required this.employeeId,
    required this.loanDate,
    required this.loanAmount,
    required this.currencyId,
    required this.loanState,
  });

  @override
  List<Object> get props =>
      [id, employeeId, loanDate, loanAmount, currencyId, loanState];
}
