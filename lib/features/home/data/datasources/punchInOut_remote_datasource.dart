// ignore_for_file: file_names

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/punchInOut_model.dart';

abstract class PunchInOutRemoteDataSource {
  Future<PunchInOutModel> punchInOut({required int userId});
}

class PunchInOutRemoteDataSourceImpl implements PunchInOutRemoteDataSource {
  ApiConsumer apiConsumer;

  PunchInOutRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<PunchInOutModel> punchInOut({required int userId}) async {
    final response = await apiConsumer.post(EndPoints.punchInOut, body: {
      "jsonrpc": "2.0",
      "params": {"user_id": userId}
    });
    return PunchInOutModel.fromJson(response);
  }
}
