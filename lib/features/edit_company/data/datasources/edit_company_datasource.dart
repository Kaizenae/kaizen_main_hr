import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/edit_company_model.dart';

abstract class EditCompanyRemoteDataSource {
  Future<EditCompanyModel> editLocation(
      {required String lat, required String long, required int companyId});
}

class EditCompanyRemoteDataSourceImpl implements EditCompanyRemoteDataSource {
  ApiConsumer apiConsumer;

  EditCompanyRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<EditCompanyModel> editLocation(
      {required String lat,
      required String long,
      required int companyId}) async {
    final response = await apiConsumer.post(EndPoints.updateCompany, body: {
      "jsonrpc": "2.0",
      "params": {"id": companyId, "lat": lat, "long": long}
    });

    return EditCompanyModel.fromJson(response);
  }
}
