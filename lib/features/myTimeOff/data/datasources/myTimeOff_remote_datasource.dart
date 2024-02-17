// ignore_for_file: file_names

import 'package:Attendace/core/utils/constants_manager.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/myTimeOff_model.dart';

abstract class MyTimeOffRemoteDataSource {
  Future<MyTimeOffModel> myTimeOff({required int userId});
  Future<MyTimeOffModel> allTimeOff();
}

class MyTimeOffRemoteDataSourceImpl implements MyTimeOffRemoteDataSource {
  ApiConsumer apiConsumer;

  MyTimeOffRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<MyTimeOffModel> myTimeOff({required int userId}) async {
    final response = await apiConsumer.get(EndPoints.allTimeOff, data: {
      "jsonrpc": "2.0",
      "params": {"company_id": AppConstants.companyId, "user_id": userId}
    });
    return MyTimeOffModel.fromJson(response);
  }

  @override
  Future<MyTimeOffModel> allTimeOff() async {
    final response = await apiConsumer.get(EndPoints.allTimeOff, data: {
      "jsonrpc": "2.0",
      "params": {"company_id": AppConstants.companyId, "user_id": ""}
    });
    return MyTimeOffModel.fromJson(response);
  }
}
