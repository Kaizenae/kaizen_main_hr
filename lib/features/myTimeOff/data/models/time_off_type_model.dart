class TimeOffTypeModel {
  ResultsModel result = ResultsModel();
  TimeOffTypeModel();
  TimeOffTypeModel.fromJson(Map<String, dynamic> json) {
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
  late String name;

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}
