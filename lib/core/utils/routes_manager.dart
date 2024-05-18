import 'dart:io';

import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:Attendace/features/create_loan/presentation/screens/create_loan_screen.dart';
import 'package:Attendace/features/create_timeOff/presentation/screens/create_timeOff_screen.dart';
import 'package:Attendace/features/edit_company/presentation/screens/edit_company_screen.dart';
import 'package:Attendace/features/edit_company/presentation/screens/edit_location_screen.dart';
import 'package:Attendace/features/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:Attendace/features/help_and_feedback/presentation/screens/help_and_feedback_screen.dart';
import 'package:Attendace/features/hr_policies/presentation/screens/hr_policies_screen.dart';
import 'package:Attendace/features/main_features/presentation/main_features_screen.dart';
import 'package:Attendace/features/main_page_admin_screen.dart';
import 'package:Attendace/features/main_page_screen.dart';
import 'package:Attendace/features/myRequests/presentation/screens/myRequests_screen.dart';
import 'package:Attendace/features/myTimeOff/presentation/screens/myTimeOff_screen.dart';
import 'package:Attendace/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:Attendace/features/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../features/change_password/presentation/screens/change_password_screen.dart';
import '../../features/edit_profile/presentation/screens/edit_phone_screen.dart';
import '../../features/edit_profile/presentation/screens/edit_profile_screen.dart';
import '../../features/edit_profile/presentation/screens/edit_userName_screen.dart';
import '../../features/expenses/presentation/screens/screens/expenses_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/login/presentation/screens/login_screen.dart';

// import '../screens/admin/admin_home.dart';
// import '../screens/admin/requests_screen.dart';
import '../../features/myLoans/presentation/screens/myLoans_screen.dart';
import '../../features/register/presentation/screens/register.dart';
import '../../features/shift_allocation/presentation/screen/shift_allocation_screen.dart';
import '../widgets/app_bar/app_bar_custom.dart';
import '../widgets/text_custom/text_custom.dart';

// import '../screens/home_screen.dart';
// import '../screens/user_screen/user_requests_screen.dart';
// import '../screens/user_screen/user_screen.dart';

class Routes {
  static const String loginRoute = "login";
  static const String baseUrlRoute = "baseUrlScreen";
  static const String mainRoute = "mainPage";
  static const String localAuthRoute = "LocalAuth";
  static const String splashRoute = "SplashScreen";
  static const String mainFeatureRoute = "MainFeatureScreen";
  static const String mainRouteAdmin = "mainPageAdmin";
  static const String homeRoute = "home";
  static const String registerRoute = "register";
  static const String userRoute = "userData";
  static const String adminRoute = "adminScreen";
  static const String requestsRoute = "requests";
  static const String createRequestRoute = "createRequestScreen";
  static const String createTimeOffRoute = "createTimeOffScreen";
  static const String userRequestsRoute = "userRequests";
  static const String editProfileRoute = "editProfile";
  static const String editCompanyRoute = "editCompany";
  static const String editUserNameRoute = "editUserName";
  static const String editCompanyLocationRoute = "editCompanyLocation";
  static const String editPhoneNumberRoute = "editPhoneNumber";
  static const String changePasswordRoute = "changePassword";
  static const String myRequestsRoute = "myRequests";
  static const String myLoansRoute = "myLoans";
  static const String myTimeOffRoute = "myTimeOff";
  static const String settingsRoute = "settings";
  static const String employeeRoute = "EmployeeScreen";
  static const String notificationsRoute = "notificationsScreen";
  static const String webViewExampleRoute = "WebViewExample";
  static const String helpRoute = "HelpScreen";
  static const String createLoanRoute = "CreateLoanScreen";
  static const String lateInRequestRoute = "lateInRequestRoute";
  static const String earlyOutRequestRoute = "earlyOutRequestRoute";
  static const String forgetPasswordRoute = "forrgetPasswordRoute";
  static const String otpScreenRoute = "otpScreenRoute";
  static const String createNewPasswordRoute = "createNewPasswordRoute";
  static const String hrPoliciesRoute = "hrPoliciesRoute";
  static const String shiftAllocationRoute = "shiftAllocationRoute";
  static const String attendanceRoute = "attendanceRoute";
  static const String expensesRoute = "expensesRoute";

  static Route createRoute(String screen) {
    if (Platform.isAndroid) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            RoutesMap.routeMap(screen),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    } else {
      return CupertinoPageRoute(
        builder: (BuildContext context) => RoutesMap.routeMap(screen),
      );
    }
  }
}

class RoutesMap {
  static Map<String, Widget Function(BuildContext)> routesMap() {
    return {
      Routes.loginRoute: (BuildContext context) => const LoginScreen(),
      Routes.mainFeatureRoute: (BuildContext context) =>
          const MainFeaturesScreen(),
      Routes.registerRoute: (BuildContext context) => const RegisterScreen(),
      Routes.homeRoute: (BuildContext context) => const HomeScreen(),
      Routes.myRequestsRoute: (BuildContext context) =>
          const MyRequestsScreen(),
      Routes.myLoansRoute: (BuildContext context) => const MyLoansScreen(),
      Routes.myTimeOffRoute: (BuildContext context) => const MyTimeOffScreen(),
      Routes.notificationsRoute: (BuildContext context) =>
          const NotificationsScreen(),

      Routes.createTimeOffRoute: (BuildContext context) =>
          const CreateTimeOffScreen(),
      Routes.mainRoute: (BuildContext context) => const MainPage(),
      Routes.mainRouteAdmin: (BuildContext context) => const MainPageAdmin(),
      Routes.editProfileRoute: (BuildContext context) =>
          const EditProfileScreen(),
      Routes.editUserNameRoute: (BuildContext context) =>
          const EditUserNameScreen(),
      Routes.editCompanyRoute: (BuildContext context) =>
          const EditCompanyScreen(),
      Routes.editCompanyLocationRoute: (BuildContext context) =>
          const EditLocationScreen(),
      Routes.editPhoneNumberRoute: (BuildContext context) =>
          const EditPhoneScreen(),

      Routes.changePasswordRoute: (BuildContext context) =>
          const ChangePasswordScreen(),
      // Routes.webViewExampleRoute: (BuildContext context) =>
      //     const WebViewExample(),
      Routes.helpRoute: (BuildContext context) => HelpAndFeedbackScreen(),
      Routes.createLoanRoute: (BuildContext context) =>
          const CreateLoanScreen(),
      Routes.splashRoute: (BuildContext context) => const SplashScreen(),
      Routes.forgetPasswordRoute: (BuildContext context) =>
          const ForgetPasswordScreen(),

      Routes.hrPoliciesRoute: (BuildContext context) =>
          const HrPoliciesScreen(),
      Routes.shiftAllocationRoute: (BuildContext context) =>
          const ShiftAllocationScreen(),
      Routes.attendanceRoute: (BuildContext context) =>
          const AttendanceScreen(),
      Routes.expensesRoute: (BuildContext context) => const ExpensesScreen(),

      // 'userData': (BuildContext context) => const UserScreen(),
      // 'adminScreen': (BuildContext context) => const AdminHomeScreen(),
      // 'requests': (BuildContext context) => const RequestsScreen(),
      // 'userRequests': (BuildContext context) => const UserRequestsScreen(),
    };
  }

  static Widget routeMap(String screen) {
    switch (screen) {
      case Routes.loginRoute:
        return const LoginScreen();

      case Routes.registerRoute:
        return const RegisterScreen();

      case Routes.mainFeatureRoute:
        return const MainFeaturesScreen();

      case Routes.myRequestsRoute:
        return const MyRequestsScreen();
      case Routes.myLoansRoute:
        return const MyLoansScreen();
      case Routes.myTimeOffRoute:
        return const MyTimeOffScreen();

      case Routes.notificationsRoute:
        return const NotificationsScreen();
      case Routes.forgetPasswordRoute:
        return const ForgetPasswordScreen();

      case Routes.mainRoute:
        return const MainPage();
      case Routes.mainRouteAdmin:
        return const MainPageAdmin();

      case Routes.editProfileRoute:
        return const EditProfileScreen();
      case Routes.editUserNameRoute:
        return const EditUserNameScreen();

      case Routes.editCompanyRoute:
        return const EditCompanyScreen();
      case Routes.editCompanyLocationRoute:
        return const EditLocationScreen();

      case Routes.editPhoneNumberRoute:
        return const EditPhoneScreen();

      case Routes.changePasswordRoute:
        return const ChangePasswordScreen();
      // case Routes.webViewExampleRoute:
      //   return const WebViewExample();
      case Routes.helpRoute:
        return HelpAndFeedbackScreen();
      case Routes.createLoanRoute:
        return const CreateLoanScreen();
      case Routes.createTimeOffRoute:
        return const CreateTimeOffScreen();

      case Routes.splashRoute:
        return const SplashScreen();

      case Routes.hrPoliciesRoute:
        return const HrPoliciesScreen();
      case Routes.shiftAllocationRoute:
        return const ShiftAllocationScreen();
      case Routes.expensesRoute:
        return const ExpensesScreen();
      case Routes.attendanceRoute:
        return const AttendanceScreen();
      default:
        return ScaffoldCustom(
          appBarCustom: const AppBarCustom(
            text: AppStrings.noRouteFound,
          ),
          body: Center(
              child: TextCustom(
            color: ColorManager.primary,
            text: AppStrings.noRouteFound,
            fontSize: FontSize.s14,
          )),
        );
    }
  }
}
