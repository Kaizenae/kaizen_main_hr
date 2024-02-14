import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/change_password_model.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<ChangePasswordModel> changePassword(
      {required String oldPassword,
      required String newPassword,
      required int userId});
}

class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  ApiConsumer apiConsumer;

  ChangePasswordRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ChangePasswordModel> changePassword(
      {required String oldPassword,
      required String newPassword,
      required int userId}) async {
    final response =
        await apiConsumer.put(EndPoints.changePasswordEndpoint, body: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": [userId],
        "user_password_old": oldPassword,
        "user_password_new": newPassword,
      }
    });

    return ChangePasswordModel.fromJson(response);
  }
}
