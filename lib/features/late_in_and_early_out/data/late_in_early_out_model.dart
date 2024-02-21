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
  late int companyId;
  late String reason;
  late String state;
  late String date;

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"];
    companyId = json["company_id"];
    reason = json["reason"];
    state = json["state"];
    date = json["date"];
  }
}
