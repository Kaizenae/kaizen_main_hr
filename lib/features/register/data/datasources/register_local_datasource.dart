import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/strings_manager.dart';
import '../models/register_model.dart';

abstract class RegisterLocalDataSource {
  Future<RegisterModel> getLastRegister();
  Future<void> cacheRegister(RegisterModel registerModel);
}

class RegisterLocalDataSourceImpl implements RegisterLocalDataSource {
  final SharedPreferences sharedPreferences;

  RegisterLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheRegister(RegisterModel registerModel) async {}

  @override
  Future<RegisterModel> getLastRegister() {
    final jsonString = sharedPreferences.getString(AppStrings.cachedRegister);
    if (jsonString != null) {
      final cacheRegister =
          Future.value(RegisterModel.fromJson(json.decode(jsonString)));
      return cacheRegister;
    } else {
      throw CacheException();
    }
  }
}
