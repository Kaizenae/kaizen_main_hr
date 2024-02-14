import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

// class ServerFailure extends Failure {
//   int? code; // 200, 201, 400, 303..500 and so on
//   String? message; // error , success
//
//   ServerFailure({this.code = 200, this.message=''});
// }

class CacheFailure extends Failure {}
