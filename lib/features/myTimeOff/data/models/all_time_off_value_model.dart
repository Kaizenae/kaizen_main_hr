class AllTimeOffValueModel {
  ResultsModel result = ResultsModel();
  AllTimeOffValueModel();
  AllTimeOffValueModel.fromJson(Map<String, dynamic> json) {
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
  late int timeOffAllocation;
  late double timeOffAllocationRemainingValue;

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    timeOffAllocation = json["time_off_allocation"];
    timeOffAllocationRemainingValue =
        json["time_off_allocation_remaining_value"];
  }
}
