class OddPunchModel {
  ResultsModel result = ResultsModel();
  OddPunchModel();
  OddPunchModel.fromJson(Map<String, dynamic> json) {
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
  late int recordId;
  late String punchingTime;

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    recordId = json["record_id"];
    punchingTime = json["punching_time"];
  }
}
