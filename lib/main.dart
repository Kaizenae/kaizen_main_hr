// ignore_for_file: deprecated_member_use

import 'package:Attendace/features/create_request/presentation/controller/apply_request_cubit.dart';
import 'package:Attendace/features/create_timeOff/presentation/controller/create_timeOff_cubit.dart';
import 'package:Attendace/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:Attendace/features/notifications/presentation/controllers/accept_reject_timeOff/accept_reject_request_cubit.dart';

import 'package:Attendace/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/local/cache_helper.dart';
import 'features/all_employee/presentation/cubit/all_employees_cubit.dart';
import 'features/attendance/presentation/controller/attendance_cubit.dart';
import 'features/companies/presentation/cubit/companies_cubit.dart';
import 'features/create_loan/presentation/controller/create_loan_cubit.dart';
import 'features/create_loan/presentation/controller/currency_controller/currency_cubit.dart';
import 'features/create_timeOff/presentation/controller/timeOff_controller/timeOff_cubit.dart';
import 'features/edit_company/presentation/cubit/edit_company_cubit.dart';
import 'features/home/presentation/controller/home_cubit.dart';
import 'features/login/presentation/cubit/login_cubit.dart';
import 'features/myRequests/presentation/controller/myRequests_cubit.dart';
import 'features/myLoans/presentation/controller/myLoans_cubit.dart';
import 'features/myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import 'features/notifications/presentation/controllers/accept_reject_request/accept_reject_request_cubit.dart';
import 'features/register/presentation/cubit/register_cubit.dart';
import 'injection_container.dart';
import 'observer.dart';
import 'core/utils/constants_manager.dart';
import 'core/utils/routes_manager.dart';
import 'core/utils/strings_manager.dart';
import 'core/utils/theme_manager.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DioHelper.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await CacheHelper.init();
  await di.init();

  Bloc.observer = MyBlocObserver();

  AppConstants.token = CacheHelper.get(key: AppStrings.token) ?? 0;
  AppConstants.admin = CacheHelper.get(key: AppStrings.admin) ?? false;

  // EndPoints.baseUrl();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<RegisterCubit>()),
        BlocProvider(create: (context) => sl<LoginCubit>()),
        BlocProvider(create: (context) => sl<HomeCubit>()),
        BlocProvider(create: (context) => sl<ProfileCubit>()),
        BlocProvider(create: (context) => sl<AttendanceCubit>()),
        BlocProvider(create: (context) => sl<MyRequestsCubit>()),
        BlocProvider(create: (context) => sl<MyLoansCubit>()),
        BlocProvider(create: (context) => sl<CreateLoanCubit>()),
        BlocProvider(create: (context) => sl<CurrencyCubit>()),
        BlocProvider(create: (context) => sl<MyTimeOffCubit>()),
        BlocProvider(create: (context) => sl<TimeOffCubit>()),
        BlocProvider(create: (context) => sl<ApplyRequestCubit>()),
        BlocProvider(create: (context) => sl<EditProfileCubit>()),
        BlocProvider(create: (context) => sl<EditCompanyCubit>()),
        BlocProvider(create: (context) => sl<AllEmployeesCubit>()),
        BlocProvider(create: (context) => sl<CreateTimeOffCubit>()),
        BlocProvider(create: (context) => sl<AcceptRejectTimeOffCubit>()),
        BlocProvider(create: (context) => sl<AcceptRejectRequestCubit>()),
        BlocProvider(
            create: (context) => sl<CompaniesCubit>()..getCompaniesFun()),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Material(child: child!)),
        title: 'KAIZEN HR',
        theme: getApplicationTheme(),
        routes: RoutesMap.routesMap(),

        initialRoute: Routes.splashRoute,
        // home: const LocalAuthScreen(),
        // EndPoints.baseUrl().isEmpty
        //     ? const BaseUrlScreen()
        //     : AppConstants.token == AppStrings.empty ||
        //             AppConstants.token == 0
        //         ? const LoginScreen()
        //         : AppConstants.admin
        //             ? const MainPageAdmin()
        //             : const MainPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
