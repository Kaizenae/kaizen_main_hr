// ignore_for_file: file_names

import 'package:Attendace/core/utils/constants_manager.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/myRequests_model.dart';

abstract class MyRequestsRemoteDataSource {
  Future<MyRequestsModel> myRequests({required int userId});
  Future<MyRequestsModel> myRequestsPending({required dynamic userId});
}

class MyRequestsRemoteDataSourceImpl implements MyRequestsRemoteDataSource {
  ApiConsumer apiConsumer;

  MyRequestsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<MyRequestsModel> myRequests({required int userId}) async {
    final response =
        await apiConsumer.get(EndPoints.allRequestsAccepted, data: {
      "jsonrpc": "2.0",
      "params": {"company_id": AppConstants.companyId, "user_id": userId}
    });
    return MyRequestsModel.fromJson(response);
  }

  @override
  Future<MyRequestsModel> myRequestsPending({required dynamic userId}) async {
    final response =
        await apiConsumer.get(EndPoints.allRequestsNotAccepted, data: {
      "jsonrpc": "2.0",
      "params": {"company_id": AppConstants.companyId, "user_id": userId}
    });
    return MyRequestsModel.fromJson(response);
  }
}
