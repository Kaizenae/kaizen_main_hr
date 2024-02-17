// ignore_for_file: file_names

import '../../domain/entities/myRequests_entity.dart';

class MyRequestsModel extends MyRequestsEntity {
  MyRequestsModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory MyRequestsModel.fromJson(Map<String, dynamic> json) =>
      MyRequestsModel(
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
    int? employeeId,
    String? employeeName,
    String? message,
    String? date,
    String? distance,
    String? location,
    String? noId,
    String? state,
    bool? isAccept,
    String? checkType,
  }) : super(
          id: id ?? 0,
          employeeId: employeeId ?? 0,
          employeeName: employeeName ?? '',
          message: message ?? '',
          date: date ?? '',
          distance: distance ?? '',
          noId: noId ?? '',
          location: location ?? '',
          state: state ?? '',
          isAccept: isAccept ?? false,
          checkType: checkType ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        id: json['id'],
        employeeId: json['employee_id'],
        employeeName: json['employee_name'],
        message: json['message'],
        date: json['date'],
        distance: json['distance'],
        noId: json['notification_id'] == false ? '' : json['notification_id'],
        location: json['location'],
        state: json['state'],
        isAccept: json['is_accept'],
        checkType: json['check_type'],
      );
}
