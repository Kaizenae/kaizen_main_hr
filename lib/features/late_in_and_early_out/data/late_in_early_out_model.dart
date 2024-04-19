class LateinEarlyOutModel {
  ResultsModel result = ResultsModel();
  LateinEarlyOutModel();
  LateinEarlyOutModel.fromJson(Map<String, dynamic> json) {
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
  late int userId;
  late int id;
  late int companyId;
  late String reason;
  late String state;
  late String date;
  List<ApproversModel> approvers = [];

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"];
    id = json["id"];
    companyId = json["company_id"];
    reason = json["reason"];
    state = json["state"];
    date = json["date"];
    json["approvers"].forEach((element) {
      approvers.add(ApproversModel.fromJson(element));
    });
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
