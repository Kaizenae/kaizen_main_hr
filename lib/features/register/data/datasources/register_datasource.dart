import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/register_model.dart';

abstract class RegisterRemoteDataSource {
  Future<RegisterModel> register(
      {required String email,
      required String name,
      required String phoneNumber,
      required String password,
      required int companyId,
      required String uniqueDeviceId});
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  ApiConsumer apiConsumer;

  RegisterRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<RegisterModel> register({
    required String email,
    required String name,
    required String phoneNumber,
    required String password,
    required int companyId,
    required String uniqueDeviceId,
  }) async {
    final response = await apiConsumer.post(EndPoints.registerUrl, body: {
      "jsonrpc": "2.0",
      "params": {
        "name": name,
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
        "company_id": companyId,
        "device_id": uniqueDeviceId
      }
    });
    return RegisterModel.fromJson(response);
  }
}
