import 'package:Attendace/core/utils/assets_manager.dart';
import '../../features/home/data/models/feautre_model.dart';
import '../local/cache_helper.dart';
import 'routes_manager.dart';
import 'strings_manager.dart';

class AppConstants {
  static String appVersion = "5.8.0";
  static int token = CacheHelper.get(key: AppStrings.token) ?? 0;
  static int companyId = CacheHelper.get(key: AppStrings.company) ?? 0;
  static bool isPunched = CacheHelper.get(key: AppStrings.punched) ?? false;
  static bool admin = CacheHelper.get(key: AppStrings.admin) ?? false;
  static List<String> admins = [];

  static String userId = '';
  static String employeeName = '';
  static bool connected = true;
  static String punchIn = '';
  static int snackBarTime = 5;
  static List<FeatureModel> featureList = [
    FeatureModel(
      backgroundImg: ImageAssets.back8,
      title: AppStrings.myLeave,
      icon: ImageAssets.timeOffImg,
      route: Routes.myTimeOffRoute,
    ),
    FeatureModel(
      backgroundImg: ImageAssets.back1,
      title: AppStrings.overTime,
      icon: ImageAssets.overTimeImg,
      route: "",
    ),
    FeatureModel(
      backgroundImg: ImageAssets.back10,
      title: AppStrings.myLateIn,
      icon: ImageAssets.lateInImg,
      route: "Late In",
    ),
    FeatureModel(
      backgroundImg: ImageAssets.back2,
      title: AppStrings.myEarlyOut,
      icon: ImageAssets.checkOut,
      route: "Early Out",
    ),
    FeatureModel(
      backgroundImg: ImageAssets.back3,
      title: AppStrings.hrPolicy,
      icon: ImageAssets.policyImg,
      route: Routes.hrPoliciesRoute,
    ),
    FeatureModel(
      backgroundImg: ImageAssets.back4,
      title: AppStrings.myShiftAllocation,
      icon: ImageAssets.shiftAllocationImg,
      route: Routes.shiftAllocationRoute,
    ),
    FeatureModel(
      backgroundImg: ImageAssets.back5,
      title: AppStrings.myAttendance,
      icon: ImageAssets.attendanceImg,
      route: Routes.attendanceRoute,
    ),
  ];
}
