import '../../domain/entities/edit_profile_entity.dart';

class EditProfileModel extends EditProfileEntity {
  EditProfileModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      EditProfileModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    List<String>? message,
  }) : super(
          status: status ?? false,
          message: message ?? [],
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['success'],
        message: json['message'].cast<String>(),
      );

  Map<String, dynamic> toJson() => {
        'success': status,
        'message': message,
      };
}
