import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/attendance_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceModel> attendance({required int userId});
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  ApiConsumer apiConsumer;

  AttendanceRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AttendanceModel> attendance({required int userId}) async {
    final response = await apiConsumer.get(EndPoints.attendance, data: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": userId,
      }
    });
    return AttendanceModel.fromJson(response);
  }
}
