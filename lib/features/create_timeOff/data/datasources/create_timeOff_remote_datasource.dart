// ignore_for_file: file_names

import 'package:Attendace/core/utils/constants_manager.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/create_timeOff_model.dart';
import '../models/get_timeOff_model.dart';

abstract class CreateTimeOffRemoteDataSource {
  Future<CreateTimeOffModel> createTimeOff({
    required int userId,
    required String startDate,
    required String endDate,
    required int holidayStatus,
  });
  Future<GetTimeOffModel> getTimeoff();
}

class CreateTimeOffRemoteDataSourceImpl
    implements CreateTimeOffRemoteDataSource {
  ApiConsumer apiConsumer;

  CreateTimeOffRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CreateTimeOffModel> createTimeOff({
    required int userId,
    required String startDate,
    required String endDate,
    required int holidayStatus,
  }) async {
    final response =
        await apiConsumer.post(EndPoints.createTimeOffEndpoint, body: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": userId,
        "start": startDate,
        "holiday_status": holidayStatus,
        "company_id": AppConstants.companyId,
        "end": endDate,
      }
    });
    return CreateTimeOffModel.fromJson(response);
  }

  @override
  Future<GetTimeOffModel> getTimeoff() async {
    final response = await apiConsumer
        .get(EndPoints.getTimeOff, data: {"jsonrpc": "2.0", "params": {}});
    return GetTimeOffModel.fromJson(response);
  }
}
