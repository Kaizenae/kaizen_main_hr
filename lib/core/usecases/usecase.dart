// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyParams extends Equatable {
  final int companyId;

  const CompanyParams({
    required this.companyId,
  });

  @override
  List<Object?> get props => [companyId];
}

class LoginParams extends Equatable {
  final String email;
  final String password;
  final String uniqueDeviceId;

  const LoginParams({
    required this.email,
    required this.password,
    required this.uniqueDeviceId,
  });

  @override
  List<Object?> get props => [email, password];
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String uniqueDeviceId;
  final String phoneNumber;
  final int companyId;
  final String employeeCode;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.uniqueDeviceId,
    required this.name,
    required this.companyId,
    required this.phoneNumber,
    required this.employeeCode,
  });

  @override
  List<Object> get props => [
        name,
        email,
        password,
        uniqueDeviceId,
        phoneNumber,
        employeeCode,
      ];
}

class ApplyRequestParams extends Equatable {
  final int userId;
  final String message;
  final String date;
  final String distance;
  final String location;
  final String check_type;

  const ApplyRequestParams({
    required this.message,
    required this.date,
    required this.distance,
    required this.userId,
    required this.location,
    required this.check_type,
  });

  @override
  List<Object> get props =>
      [userId, message, date, distance, location, check_type];
}

class CreateLoanParams extends Equatable {
  final int userId;
  final double loanAmount;
  final int currencyId;

  const CreateLoanParams({
    required this.loanAmount,
    required this.currencyId,
    required this.userId,
  });

  @override
  List<Object> get props => [userId, loanAmount, currencyId];
}

class CreateTimeOffParams extends Equatable {
  final int userId;
  final String startDate;
  final String endDate;
  final int holidayStatus;
  final String attachment;

  const CreateTimeOffParams({
    required this.startDate,
    required this.endDate,
    required this.userId,
    required this.holidayStatus,
    required this.attachment,
  });

  @override
  List<Object> get props => [
        userId,
        startDate,
        endDate,
        holidayStatus,
        attachment,
      ];
}

class EmployeeParams extends Equatable {
  final dynamic userId;
  final int? companyId;

  const EmployeeParams({required this.userId, this.companyId});

  @override
  List<Object> get props => [userId];
}

class UpdateLoanParams extends Equatable {
  final dynamic userId;
  final int loanId;
  final String state;

  const UpdateLoanParams(
      {required this.userId, required this.loanId, required this.state});

  @override
  List<Object> get props => [userId, loanId];
}

class EditProfileParams extends Equatable {
  final String? userName;
  final String? phoneNumber;
  final String? noId;
  final int userId;

  const EditProfileParams(
      {this.userName, this.phoneNumber, this.noId, required this.userId});

  @override
  List<Object> get props => [userName!, phoneNumber!, noId!];
}

class EditCompanyParams extends Equatable {
  final String lat;
  final String long;
  final int companyId;

  const EditCompanyParams(
      {required this.lat, required this.long, required this.companyId});

  @override
  List<Object> get props => [lat, long, companyId];
}

class AcceptRejectRequestParams extends Equatable {
  final String state;
  final int id;
  final int is_accept;

  const AcceptRejectRequestParams(
      {required this.is_accept, required this.state, required this.id});

  @override
  List<Object> get props => [state, id, is_accept];
}

class AcceptRejectTimeOffParams extends Equatable {
  final String state;
  final int leavesId;

  const AcceptRejectTimeOffParams({
    required this.leavesId,
    required this.state,
  });

  @override
  List<Object> get props => [state, leavesId];
}

class ChangePasswordParams extends Equatable {
  final String oldPassword;
  final int userId;
  final String newPassword;

  const ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
    required this.userId,
  });

  @override
  List<Object> get props => [oldPassword, newPassword];
}
