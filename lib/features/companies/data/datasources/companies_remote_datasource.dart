import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/companies_model.dart';

abstract class CompaniesRemoteDataSource {
  Future<CompaniesModel> companies({required int companyId});
}

class CompaniesRemoteDataSourceImpl implements CompaniesRemoteDataSource {
  ApiConsumer apiConsumer;

  CompaniesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CompaniesModel> companies({required int companyId}) async {
    EndPoints.baseUrl;
    final response = await apiConsumer.get(EndPoints.getCompaniesUrl, data: {
      "params": {"company_id": companyId}
    });
    return CompaniesModel.fromJson(response);
  }
}
