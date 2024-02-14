import 'dart:io';

import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/features/create_loan/presentation/screens/create_loan_screen.dart';
import 'package:Attendace/features/create_request/presentation/screens/apply_request_screen.dart';
import 'package:Attendace/features/create_timeOff/presentation/screens/create_timeOff_screen.dart';
import 'package:Attendace/features/edit_company/presentation/screens/edit_company_screen.dart';
import 'package:Attendace/features/edit_company/presentation/screens/edit_location_screen.dart';
import 'package:Attendace/features/help_and_feedback/presentation/screens/help_and_feedback_screen.dart';
import 'package:Attendace/features/late_in_and_early_out/presentation/screens/late_in_and_early_out_screen.dart';
import 'package:Attendace/features/login/presentation/screens/baseUrl_screen.dart';
import 'package:Attendace/features/main_page_admin_screen.dart';
import 'package:Attendace/features/main_page_screen.dart';
import 'package:Attendace/features/myRequests/presentation/screens/myRequests_screen.dart';
import 'package:Attendace/features/myTimeOff/presentation/screens/myTimeOff_screen.dart';
import 'package:Attendace/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:Attendace/features/splash_screen/splash_screen.dart';
import 'package:Attendace/local_auth_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../features/all_employee/presentation/screens/employee_screen.dart';
import '../../features/change_password/presentation/screens/change_password_screen.dart';
import '../../features/edit_profile/presentation/screens/edit_phone_screen.dart';
import '../../features/edit_profile/presentation/screens/edit_profile_screen.dart';
import '../../features/edit_profile/presentation/screens/edit_userName_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/login/presentation/screens/login_screen.dart';

// import '../screens/admin/admin_home.dart';
// import '../screens/admin/requests_screen.dart';
import '../../features/myLoans/presentation/screens/myLoans_screen.dart';
import '../../features/register/presentation/screens/register.dart';
import '../../features/webViews/webView_screen.dart';
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
      Routes.baseUrlRoute: (BuildContext context) => const BaseUrlScreen(),
      Routes.registerRoute: (BuildContext context) => const RegisterScreen(),
      Routes.homeRoute: (BuildContext context) => const HomeScreen(),
      Routes.myRequestsRoute: (BuildContext context) =>
          const MyRequestsScreen(),
      Routes.myLoansRoute: (BuildContext context) => const MyLoansScreen(),
      Routes.myTimeOffRoute: (BuildContext context) => const MyTimeOffScreen(),
      Routes.notificationsRoute: (BuildContext context) =>
          const NotificationsScreen(),
      Routes.createRequestRoute: (BuildContext context) =>
          const ApplyRequestScreen(),
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
      Routes.employeeRoute: (BuildContext context) => const EmployeeScreen(),
      Routes.changePasswordRoute: (BuildContext context) =>
          const ChangePasswordScreen(),
      Routes.webViewExampleRoute: (BuildContext context) =>
          const WebViewExample(),
      Routes.helpRoute: (BuildContext context) => HelpAndFeedbackScreen(),
      Routes.createLoanRoute: (BuildContext context) =>
          const CreateLoanScreen(),
      Routes.localAuthRoute: (BuildContext context) => const LocalAuthScreen(),
      Routes.splashRoute: (BuildContext context) => const SplashScreen(),
      Routes.lateInRequestRoute: (BuildContext context) =>
          const LateInEarlyOutScreen(title: AppStrings.lateInRequest),
      Routes.earlyOutRequestRoute: (BuildContext context) =>
          const LateInEarlyOutScreen(title: AppStrings.earlyOutRequest),

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
      case Routes.baseUrlRoute:
        return const BaseUrlScreen();

      case Routes.registerRoute:
        return const RegisterScreen();

      case Routes.myRequestsRoute:
        return const MyRequestsScreen();
      case Routes.myLoansRoute:
        return const MyLoansScreen();
      case Routes.myTimeOffRoute:
        return const MyTimeOffScreen();

      case Routes.notificationsRoute:
        return const NotificationsScreen();

      case Routes.createRequestRoute:
        return const ApplyRequestScreen();

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
      case Routes.employeeRoute:
        return const EmployeeScreen();
      case Routes.changePasswordRoute:
        return const ChangePasswordScreen();
      case Routes.webViewExampleRoute:
        return const WebViewExample();
      case Routes.helpRoute:
        return HelpAndFeedbackScreen();
      case Routes.createLoanRoute:
        return const CreateLoanScreen();
      case Routes.createTimeOffRoute:
        return const CreateTimeOffScreen();
      case Routes.localAuthRoute:
        return const LocalAuthScreen();
      case Routes.splashRoute:
        return const SplashScreen();

      default:
        return const ScaffoldCustom(
          appBarCustom: AppBarCustom(
            text: AppStrings.noRouteFound,
          ),
          body: Center(child: TextCustom(text: AppStrings.noRouteFound)),
        );
    }
  }
}

// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.loginRoute:
//         return MaterialPageRoute(
//             builder: (_) => AppConstants.token == AppStrings.empty
//                 ? const LoginScreen()
//                 : AppConstants.admin
//                     ? AdminHomeScreen()
//                     : HomeScreen());
//       case Routes.homeRoute:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//       case Routes.registerRoute:
//         return MaterialPageRoute(builder: (_) => const RegisterScreen());
//       case Routes.userRoute:
//         return MaterialPageRoute(builder: (_) => const UserScreen());
//       case Routes.adminRoute:
//         return MaterialPageRoute(builder: (_) => const AdminHomeScreen());
//       case Routes.requestsRoute:
//         return MaterialPageRoute(builder: (_) => const RequestsScreen());
//       case Routes.userRequestsRoute:
//         return MaterialPageRoute(builder: (_) => const UserRequestsScreen());
//
//       default:
//         return unDefinedRoute();
//     }
//   }
//
//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//         builder: (_) => Scaffold(
//               appBar: AppBarCustom(
//                 text: AppStrings.noRouteFound,
//               ),
//               body: const Center(
//                   child: TextCustom(text: AppStrings.noRouteFound)),
//             ));
//   }
// }
