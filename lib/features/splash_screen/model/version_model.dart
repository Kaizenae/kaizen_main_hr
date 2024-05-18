class VersionModel {
  Result result = Result();
  VersionModel();
  VersionModel.fromJson(Map<String, dynamic> json) {
    result = Result.fromJson(json["result"]);
  }
}

class Result {
  String version = "";
  Result();
  Result.fromJson(Map<String, dynamic> json) {
    version = json["version"];
  }
}
