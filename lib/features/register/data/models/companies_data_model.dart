// ignore_for_file: prefer_typing_uninitialized_variables

class CompaniesDataModel {
  ResultsModel result = ResultsModel();
  CompaniesDataModel();
  CompaniesDataModel.fromJson(Map<String, dynamic> json) {
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
  int? companyId;
  String? companyName;

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    companyId = json["company_id"];
    companyName = json["company_name"];
  }
}
