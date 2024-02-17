// ignore_for_file: file_names

import 'package:Attendace/core/utils/constants_manager.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/myLoans_model.dart';

abstract class MyLoansRemoteDataSource {
  Future<MyLoansModel> myLoans({required int userId});

  Future<MyLoansModel> cancelMyLoans(
      {required int userId, required int loanId, required String state});
}

class MyLoansRemoteDataSourceImpl implements MyLoansRemoteDataSource {
  ApiConsumer apiConsumer;

  MyLoansRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<MyLoansModel> myLoans({required int userId}) async {
    final response = await apiConsumer.get(EndPoints.allLoans, data: {
      "jsonrpc": "2.0",
      "params": {"user_id": userId, "company_id": AppConstants.companyId}
    });
    return MyLoansModel.fromJson(response);
  }

  @override
  Future<MyLoansModel> cancelMyLoans(
      {required int userId, required int loanId, required String state}) async {
    final response = await apiConsumer.put(EndPoints.updateLoansStatus, body: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": userId,
        "loan_id": loanId,
        "company_id": AppConstants.companyId,
        "state": state
      }
    });
    return MyLoansModel.fromJson(response);
  }
}
