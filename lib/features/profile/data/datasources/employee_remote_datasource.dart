import 'dart:developer';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/constants_manager.dart';
import '../models/employee_model.dart';

abstract class EmployeeRemoteDataSource {
  Future<EmployeeModel> employee({required int userId});
  Future<EmployeeModel> employees();
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  ApiConsumer apiConsumer;

  EmployeeRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<EmployeeModel> employee({required int userId}) async {
    final response = await apiConsumer.get(EndPoints.getEmployeeUrl, data: {
      "jsonrpc": "2.0",
      "params": {"company_id": AppConstants.companyId, "user_id": userId}
    });
    log(response.toString());
    return EmployeeModel.fromJson(response);
  }

  @override
  Future<EmployeeModel> employees() async {
    final response = await apiConsumer.get(EndPoints.getEmployeeUrl, data: {
      "jsonrpc": "2.0",
      "params": {"company_id": AppConstants.companyId, "user_id": ''}
    });
    return EmployeeModel.fromJson(response);
  }
}
