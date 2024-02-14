import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/strings_manager.dart';
import '../models/login_model.dart';

abstract class LoginLocalDataSource {
  Future<LoginModel> getLastLogin();
  Future<void> cacheLogin(LoginModel loginModel);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheLogin(LoginModel loginModel) async {
    await CacheHelper.put(
        key: AppStrings.token, value: loginModel.resultEntity.id);
    // await CacheHelper.put(key:  AppStrings.admin, value: loginModel.admin);
  }

  @override
  Future<LoginModel> getLastLogin() {
    final jsonString = sharedPreferences.getString(AppStrings.cachedLogin);
    if (jsonString != null) {
      final cacheLogin =
          Future.value(LoginModel.fromJson(json.decode(jsonString)));
      return cacheLogin;
    } else {
      throw CacheException();
    }
  }
}
