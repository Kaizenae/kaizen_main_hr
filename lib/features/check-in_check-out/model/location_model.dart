class LocationModel {
  ResultsModel result = ResultsModel();
  LocationModel();
  LocationModel.fromJson(Map<String, dynamic> json) {
    result = ResultsModel.fromJson(json["result"]);
  }
}

class ResultsModel {
  ResponseModel responseModel = ResponseModel();
  ResultsModel();
  ResultsModel.fromJson(Map<String, dynamic> json) {
    responseModel = ResponseModel.fromJson(json["response"]);
  }
}

class ResponseModel {
  late double latitude;
  late double longitude;

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
  }
}
