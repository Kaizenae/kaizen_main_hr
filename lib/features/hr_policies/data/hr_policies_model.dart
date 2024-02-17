class HrPoliciesModel {
  ResultsModel result = ResultsModel();
  HrPoliciesModel();
  HrPoliciesModel.fromJson(Map<String, dynamic> json) {
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
  late String name;
  late String description;

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    description = json["description"];
  }
}
