class CheckInCheckOutModel {
  Result result = Result();
  CheckInCheckOutModel();
  CheckInCheckOutModel.fromJson(Map<String, dynamic> json) {
    result = Result.fromJson(json["result"]);
  }
}

class Result {
  bool? checking;
  Result();
  Result.fromJson(Map<String, dynamic> json) {
    checking = json["checking"];
  }
}
