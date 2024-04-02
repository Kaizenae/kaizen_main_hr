class RequestsModel {
  ResultsModel result = ResultsModel();
  RequestsModel();
  RequestsModel.fromJson(Map<String, dynamic> json) {
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
  late String type;
  late String employeeName;
  late int companyId;
  late int duration;
  late String reason;
  late String startDate;
  late String endDate;

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    type = json["type"];
    companyId = json["company_id"];
    reason = json["reason"];
    employeeName = json["employee_name"];
    duration = json["duration"];
    startDate = json["start_date"];
    endDate = json["end_date"];
  }
}
