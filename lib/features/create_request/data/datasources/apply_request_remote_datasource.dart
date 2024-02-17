// ignore_for_file: non_constant_identifier_names

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/apply_request_model.dart';

abstract class ApplyRequestRemoteDataSource {
  Future<ApplyRequestModel> applyRequest({
    required String message,
    required String date,
    required String distance,
    required int userId,
    required String location,
    required String check_type,
  });
}

class ApplyRequestRemoteDataSourceImpl implements ApplyRequestRemoteDataSource {
  ApiConsumer apiConsumer;

  ApplyRequestRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ApplyRequestModel> applyRequest({
    required String message,
    required String date,
    required String distance,
    required int userId,
    required String location,
    required String check_type,
  }) async {
    final response = await apiConsumer.post(EndPoints.applyRequest, body: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": userId,
        "message": message,
        "date": date,
        "distance": distance,
        "location": location,
        "check_type": check_type
      }
    });
    return ApplyRequestModel.fromJson(response);
  }
}
