import 'package:Attendace/features/change_password/domain/usecases/change_password_usecase.dart';
import 'package:Attendace/features/edit_company/domain/repositories/edit_company_repository.dart';
import 'package:Attendace/features/edit_company/domain/usecases/edit_company_usecase.dart';
import 'package:Attendace/features/edit_company/presentation/cubit/edit_company_cubit.dart';
import 'package:Attendace/features/notifications/presentation/controllers/accept_reject_timeOff/accept_reject_request_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';

import 'features/attendance/data/datasources/attendance_remote_datasource.dart';
import 'features/attendance/data/repositories/attendance_repository_impl.dart';
import 'features/attendance/domain/repositories/attendance_repository.dart';
import 'features/attendance/domain/usecases/attendance_usecase.dart';
import 'features/attendance/presentation/controller/attendance_cubit.dart';
import 'features/change_password/data/datasources/change_password_datasource.dart';
import 'features/change_password/data/repositories/change_password_repository_impl.dart';
import 'features/change_password/domain/repositories/change_password_repository.dart';
import 'features/change_password/presentation/cubit/change_password_cubit.dart';
import 'features/companies/data/datasources/companies_remote_datasource.dart';
import 'features/companies/data/repositories/companies_repository_impl.dart';
import 'features/companies/domain/repositories/companies_repository.dart';
import 'features/companies/domain/usecases/companies_usecase.dart';
import 'features/companies/presentation/cubit/companies_cubit.dart';
import 'features/create_loan/data/datasources/create_loan_remote_datasource.dart';
import 'features/create_loan/data/repositories/create_loan_repository_impl.dart';
import 'features/create_loan/domain/repositories/create_loan_repository.dart';
import 'features/create_loan/domain/usecases/create_loan_usecase.dart';
import 'features/create_loan/presentation/controller/create_loan_cubit.dart';
import 'features/create_loan/presentation/controller/currency_controller/currency_cubit.dart';
import 'features/create_timeOff/data/datasources/create_timeOff_remote_datasource.dart';
import 'features/create_timeOff/data/repositories/create_timeOff_repository_impl.dart';
import 'features/create_timeOff/domain/repositories/create_timeOff_repository.dart';
import 'features/create_timeOff/domain/usecases/create_timeOff_usecase.dart';
import 'features/create_timeOff/presentation/controller/create_timeOff_cubit.dart';
import 'features/create_timeOff/presentation/controller/timeOff_controller/timeOff_cubit.dart';
import 'features/edit_company/data/datasources/edit_company_datasource.dart';
import 'features/edit_company/data/repositories/edit_company_repository_impl.dart';
import 'features/edit_profile/data/datasources/edit_profile_datasource.dart';
import 'features/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'features/edit_profile/domain/usecases/edit_profile_usecase.dart';
import 'features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'features/home/data/datasources/punchInOut_remote_datasource.dart';
import 'features/home/data/repositories/punchInOut_repository_impl.dart';
import 'features/home/domain/repositories/punchInOut_repository.dart';
import 'features/home/domain/usecases/punchInOut_usecase.dart';
import 'features/home/presentation/controller/home_cubit.dart';
import 'features/login/data/datasources/login_datasource.dart';
import 'features/login/data/datasources/login_local_datasource.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/login_usecase.dart';
import 'features/login/presentation/cubit/login_cubit.dart';
import 'features/myRequests/data/datasources/myRequests_remote_datasource.dart';
import 'features/myRequests/data/repositories/myRequests_repository_impl.dart';
import 'features/myRequests/domain/repositories/myRequests_repository.dart';
import 'features/myRequests/domain/usecases/myRequests_usecase.dart';
import 'features/myRequests/presentation/controller/myRequests_cubit.dart';
import 'features/myLoans/data/datasources/myLoans_remote_datasource.dart';
import 'features/myLoans/data/repositories/myLoans_repository_impl.dart';
import 'features/myLoans/domain/repositories/myLoans_repository.dart';
import 'features/myLoans/domain/usecases/myLoans_usecase.dart';
import 'features/myLoans/presentation/controller/myLoans_cubit.dart';
import 'features/myTimeOff/data/datasources/myTimeOff_remote_datasource.dart';
import 'features/myTimeOff/data/repositories/myTimeOff_repository_impl.dart';
import 'features/myTimeOff/domain/repositories/myTimeOff_repository.dart';
import 'features/myTimeOff/domain/usecases/myTimeOff_usecase.dart';
import 'features/myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import 'features/notifications/data/datasources/accept_reject_request_datasource.dart';
import 'features/notifications/data/repositories/accept_reject_request_repository_impl.dart';
import 'features/notifications/domain/repositories/accept_reject_request_repository.dart';
import 'features/notifications/domain/usecases/accept_reject_request_usecase.dart';
import 'features/notifications/presentation/controllers/accept_reject_request/accept_reject_request_cubit.dart';
import 'features/profile/data/datasources/employee_remote_datasource.dart';
import 'features/profile/data/repositories/employee_repository_impl.dart';
import 'features/profile/domain/repositories/employee_repository.dart';
import 'features/profile/domain/usecases/employee_usecase.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';
import 'features/register/data/datasources/register_datasource.dart';
import 'features/register/data/datasources/register_local_datasource.dart';
import 'features/register/data/repositories/register_repository_impl.dart';
import 'features/register/domain/repositories/register_repository.dart';
import 'features/register/domain/usecases/register_usecase.dart';
import 'features/register/presentation/cubit/register_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  //********************************************// Blocs \\*************************************\\

  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(loginUsecase: sl()));
  sl.registerLazySingleton<RegisterCubit>(
      () => RegisterCubit(registerUsecase: sl()));
  sl.registerLazySingleton<ProfileCubit>(
      () => ProfileCubit(employeeUsecase: sl(), employeesUsecase: sl()));
  sl.registerLazySingleton<AttendanceCubit>(
      () => AttendanceCubit(attendanceUsecase: sl()));
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit(punchInOutUsecase: sl()));
  sl.registerLazySingleton<MyRequestsCubit>(() =>
      MyRequestsCubit(myRequestsUsecase: sl(), myRequestsPendingUsecase: sl()));
  sl.registerLazySingleton<EditProfileCubit>(() => EditProfileCubit(
      editProfileUsecase: sl(),
      editDepartmentUsecase: sl(),
      editNoIdUsecase: sl()));
  sl.registerLazySingleton<EditCompanyCubit>(() => EditCompanyCubit(
        editLocationUsecase: sl(),
      ));

  sl.registerLazySingleton<AcceptRejectRequestCubit>(
      () => AcceptRejectRequestCubit(
            acceptRejectRequestUsecase: sl(),
          ));
  sl.registerLazySingleton<ChangePasswordCubit>(() => ChangePasswordCubit(
        editChangePasswordUsecase: sl(),
      ));

  sl.registerLazySingleton<CompaniesCubit>(() => CompaniesCubit(
        companiesUsecase: sl(),
      ));

  sl.registerLazySingleton<MyLoansCubit>(() => MyLoansCubit(
        cancelMyLoansUsecase: sl(),
        myLeavesUsecase: sl(),
      ));

  sl.registerLazySingleton<MyTimeOffCubit>(() => MyTimeOffCubit(
        myTimeOffUsecase: sl(),
        allTimeOffUsecase: sl(),
      ));

  sl.registerLazySingleton<CreateLoanCubit>(() => CreateLoanCubit(
        createLoanUsecase: sl(),
      ));

  sl.registerLazySingleton<CreateTimeOffCubit>(() => CreateTimeOffCubit(
        createTimeOffUsecase: sl(),
      ));

  sl.registerLazySingleton<CurrencyCubit>(() => CurrencyCubit(
        getCurrencyUsecase: sl(),
      ));

  sl.registerLazySingleton<TimeOffCubit>(() => TimeOffCubit(
        getTimeOffUsecase: sl(),
      ));
  sl.registerLazySingleton<AcceptRejectTimeOffCubit>(
      () => AcceptRejectTimeOffCubit(
            acceptRejectTimeOffUsecase: sl(),
          ));

  //***************************************// Use cases \\********************************************\\

  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(sl()));
  sl.registerLazySingleton<EmployeeUsecase>(() => EmployeeUsecase(sl()));
  sl.registerLazySingleton<EmployeessUsecase>(() => EmployeessUsecase(sl()));
  sl.registerLazySingleton<AttendanceUsecase>(() => AttendanceUsecase(sl()));
  sl.registerLazySingleton<PunchInOutUsecase>(() => PunchInOutUsecase(sl()));
  sl.registerLazySingleton<MyRequestsUsecase>(() => MyRequestsUsecase(sl()));
  sl.registerLazySingleton<MyRequestsPendingUsecase>(
      () => MyRequestsPendingUsecase(sl()));
  sl.registerLazySingleton<EditUserNameUsecase>(
      () => EditUserNameUsecase(sl()));
  sl.registerLazySingleton<EditDepartmentUsecase>(
      () => EditDepartmentUsecase(sl()));
  sl.registerLazySingleton<EditNoIdUsecase>(() => EditNoIdUsecase(sl()));
  sl.registerLazySingleton<EditLocationUsecase>(
      () => EditLocationUsecase(sl()));
  sl.registerLazySingleton<AcceptRejectRequestUsecase>(
      () => AcceptRejectRequestUsecase(sl()));
  sl.registerLazySingleton<EditChangePasswordUsecase>(
      () => EditChangePasswordUsecase(sl()));
  sl.registerLazySingleton<CompaniesUsecase>(() => CompaniesUsecase(sl()));
  sl.registerLazySingleton<MyLoansUsecase>(() => MyLoansUsecase(sl()));
  sl.registerLazySingleton<MyTimeOffUsecase>(() => MyTimeOffUsecase(sl()));
  sl.registerLazySingleton<AllTimeOffUsecase>(() => AllTimeOffUsecase(sl()));
  sl.registerLazySingleton<CancelMyLoansUsecase>(
      () => CancelMyLoansUsecase(sl()));
  sl.registerLazySingleton<CreateLoanUsecase>(() => CreateLoanUsecase(sl()));
  sl.registerLazySingleton<CreateTimeOffUsecase>(
      () => CreateTimeOffUsecase(sl()));
  sl.registerLazySingleton<GetCurrencyUsecase>(() => GetCurrencyUsecase(sl()));
  sl.registerLazySingleton<GetTimeOffUsecase>(() => GetTimeOffUsecase(sl()));
  sl.registerLazySingleton<AcceptRejectTimeOffUsecase>(
      () => AcceptRejectTimeOffUsecase(sl()));
  //*******************************************// Repository \\****************************************\\

  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        loginLocalDataSource: sl(),
        loginRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(
        registerLocalDataSource: sl(),
        registerRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<EmployeeRepository>(() => EmployeeRepositoryImpl(
        employeeRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<AttendanceRepository>(() => AttendanceRepositoryImpl(
        attendanceRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<PunchInOutRepository>(() => PunchInOutRepositoryImpl(
        punchInOutRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<MyRequestsRepository>(() => MyRequestsRepositoryImpl(
        myRequestsRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<EditProfileRepository>(
      () => EditProfileRepositoryImpl(
            editProfileRemoteDataSource: sl(),
            networkInfo: sl(),
          ));
  sl.registerLazySingleton<EditCompanyRepository>(
      () => EditCompanyRepositoryImpl(
            editCompanyRemoteDataSource: sl(),
            networkInfo: sl(),
          ));

  sl.registerLazySingleton<AcceptRejectRequestRepository>(
      () => AcceptRejectRequestRepositoryImpl(
            acceptRejectRequestRemoteDataSource: sl(),
            networkInfo: sl(),
          ));

  sl.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImpl(
            changePasswordRemoteDataSource: sl(),
            networkInfo: sl(),
          ));

  sl.registerLazySingleton<CompaniesRepository>(() => CompaniesRepositoryImpl(
        companiesRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<MyLoansRepository>(() => MyLoansRepositoryImpl(
        myLoansRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<MyTimeOffRepository>(() => MyTimeOffRepositoryImpl(
        myTimeOffRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<CreateLoanRepository>(() => CreateLoanRepositoryImpl(
        applyRequestRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<CreateTimeOffRepository>(
      () => CreateTimeOffRepositoryImpl(
            applyRequestRemoteDataSource: sl(),
            networkInfo: sl(),
          ));

  //*************************************************// Data Sources \\***********************************\\

  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<RegisterLocalDataSource>(
      () => RegisterLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<EmployeeRemoteDataSource>(
      () => EmployeeRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
      () => AttendanceRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<PunchInOutRemoteDataSource>(
      () => PunchInOutRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<MyRequestsRemoteDataSource>(
      () => MyRequestsRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<EditProfileRemoteDataSource>(
      () => EditProfileRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<EditCompanyRemoteDataSource>(
      () => EditCompanyRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<AcceptRejectRequestRemoteDataSource>(
      () => AcceptRejectRequestRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<ChangePasswordRemoteDataSource>(
      () => ChangePasswordRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<CompaniesRemoteDataSource>(
      () => CompaniesRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<MyLoansRemoteDataSource>(
      () => MyLoansRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<MyTimeOffRemoteDataSource>(
      () => MyTimeOffRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<CreateLoanRemoteDataSource>(
      () => CreateLoanRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<CreateTimeOffRemoteDataSource>(
      () => CreateTimeOffRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  //!*************************************************// Core \\********************************************\\
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
