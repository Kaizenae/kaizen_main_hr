class OvertimeModel {
  ResultsModel result = ResultsModel();
  OvertimeModel();
  OvertimeModel.fromJson(Map<String, dynamic> json) {
    result = ResultsModel.fromJson(json["result"]);
  }
}

class ResultsModel {
  List<ResponseModel> responseModel = [];
  ResultsModel();
  ResultsModel.fromJson(Map<String, dynamic> json) {
    json["response"].forEach((element) {
      responseModel.add(ResponseModel.fromJson(element));
    });
  }
}

class ResponseModel {
  late int id;
  late String date;
  late String state;
  late String dateTimeFrom;
  late String dateTimeTo;
  List<ApproversModel> approvers = [];
  late String description;

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    dateTimeFrom = json["date_time_from"];
    state = json["state"];
    date = json["date"];
    dateTimeTo = json["date_time_to"];
    json["approvers"].forEach((element) {
      approvers.add(ApproversModel.fromJson(element));
    });
    description = json["description"];
  }
}

class ApproversModel {
  late int user;
  late String userName;
  late String state;
  late String reason;

  ApproversModel();
  ApproversModel.fromJson(Map<String, dynamic> json) {
    user = json["user"];
    userName = json["user_name"];
    state = json["state"];
    reason = json["reason"];
  }
}
