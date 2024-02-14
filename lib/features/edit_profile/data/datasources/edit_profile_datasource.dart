import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/edit_profile_model.dart';

abstract class EditProfileRemoteDataSource {
  Future<EditProfileModel> editProfile({String? userName, required int userId});

  Future<EditProfileModel> editPhoneNumber(
      {String? phoneNumber, String? userName, required int userId});

  Future<EditProfileModel> editNoId({String? noId, required int userId});
}

class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  ApiConsumer apiConsumer;

  EditProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<EditProfileModel> editProfile(
      {String? userName, required int userId}) async {
    final response = await apiConsumer.patch(EndPoints.updateProfile, body: {
      "jsonrpc": "2.0",
      "params": {"user_id": userId, "name": userName}
    });

    return EditProfileModel.fromJson(response);
  }

  @override
  Future<EditProfileModel> editPhoneNumber(
      {String? phoneNumber, String? userName, required int userId}) async {
    final response = await apiConsumer.patch(EndPoints.updateProfile, body: {
      "jsonrpc": "2.0",
      "params": {"user_id": userId, "name": userName, "work_phone": phoneNumber}
    });

    return EditProfileModel.fromJson(response);
  }

  @override
  Future<EditProfileModel> editNoId({String? noId, required int userId}) async {
    final response = await apiConsumer.patch(EndPoints.updateProfile, body: {
      "jsonrpc": "2.0",
      "params": {"user_id": userId, "notification_id": noId}
    });

    return EditProfileModel.fromJson(response);
  }
}
