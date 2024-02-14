// ignore_for_file: non_constant_identifier_names

import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:Attendace/features/create_timeOff/data/models/create_timeOff_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/accept_reject_request_model.dart';

abstract class AcceptRejectRequestRemoteDataSource {
  Future<AcceptRejectRequestModel> acceptRejectRequest({
    required String state,
    required int id,
    required int is_accept,
  });

  Future<CreateTimeOffModel> acceptRejectTimeOff({
    required String state,
    required int leavesId,
  });
}

class AcceptRejectRequestRemoteDataSourceImpl
    implements AcceptRejectRequestRemoteDataSource {
  ApiConsumer apiConsumer;

  AcceptRejectRequestRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AcceptRejectRequestModel> acceptRejectRequest({
    required String state,
    required int id,
    required int is_accept,
  }) async {
    final response =
        await apiConsumer.patch(EndPoints.acceptRejectEndpoint, body: {
      "jsonrpc": "2.0",
      "params": {"id": id, "is_accept": is_accept, "state": state}
    });

    return AcceptRejectRequestModel.fromJson(response);
  }

  @override
  Future<CreateTimeOffModel> acceptRejectTimeOff(
      {required String state, required int leavesId}) async {
    final response =
        await apiConsumer.patch(EndPoints.acceptRejectTimeOffEndpoint, body: {
      "jsonrpc": "2.0",
      "params": {
        "leaves_id": leavesId,
        "company_id": AppConstants.companyId,
        "state": state
      }
    });

    return CreateTimeOffModel.fromJson(response);
  }
}
