import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/constants_manager.dart';
import '../models/employees_model.dart';

abstract class EmployeesRemoteDataSource {
  Future<EmployeesModel> employees();
}

class EmployeesRemoteDataSourceImpl implements EmployeesRemoteDataSource {
  ApiConsumer apiConsumer;

  EmployeesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<EmployeesModel> employees() async {
    final response = await apiConsumer.get(EndPoints.getEmployeesUrl, data: {
      "jsonrpc": "2.0",
      "params": {"company_id": AppConstants.companyId, "user_id": ''}
    });
    return EmployeesModel.fromJson(response);
  }
}
