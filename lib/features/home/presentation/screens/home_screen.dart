import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/core/utils/routes_manager.dart';
import 'package:Attendace/core/widgets/cached_image_custom/cached_network_image.dart';
import 'package:Attendace/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:Attendace/features/attendance/presentation/controller/attendance_cubit.dart';
import 'package:Attendace/features/attendance/presentation/controller/attendance_state.dart';
import 'package:Attendace/features/companies/presentation/cubit/companies_cubit.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/progress_indicator/progress_indicator.dart';
import '../../../companies/presentation/cubit/companies_state.dart';
import '../controller/home_cubit.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../controller/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: BlocProvider.value(
        value: BlocProvider.of<HomeCubit>(context),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is CheckInAndOutSuccess) {
              showToast(
                  message: state.punchInOutEntity.resultEntity.message,
                  color: ColorManager.primary);
            } else if (state is CheckInAndOutError) {
              if (kDebugMode) {
                print(state.message);
              }
              showToast(message: state.message, color: ColorManager.error);
            }
          },
          builder: (context, state) {
            var homeCubit = HomeCubit.get(context);
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p16.r),
                child: SizedBox(
                  width: context.width,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              ImageAssets.logoImg,
                              height: AppSize.s80.w,
                              width: AppSize.s80.w,
                            ),
                            CircleAvatar(
                              radius: AppSize.s30.r,
                              backgroundColor: ColorManager.scaffoldColor,
                              child: const CachedNetworkImageCustom(
                                url:
                                    'https://res.cloudinary.com/halqetelzekr/image/upload/v1678732276/placeholder_t7jyyi.png',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: (AppSize.s40 * 3).h,
                        ),

                        // Time
                        StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)),
                          builder: (context, snapshot) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextCustom(
                                      text: DateFormat('hh: mm')
                                          .format(DateTime.now()),
                                      fontSize: FontSize.s32.sp,
                                      color: ColorManager.black,
                                    ),
                                    SizedBox(
                                      width: AppSize.s4.w,
                                    ),
                                    TextCustom(
                                      text: DateFormat('ss')
                                          .format(DateTime.now()),
                                      fontSize: FontSize.s22,
                                      color: ColorManager.black,
                                    ),
                                    SizedBox(
                                      width: AppSize.s4.w,
                                    ),
                                    TextCustom(
                                      text: DateFormat('a')
                                          .format(DateTime.now()),
                                      fontSize: FontSize.s22.sp,
                                    ),
                                  ],
                                ),
                                TextCustom(
                                  text: DateFormat('EEE, MMM dd, yyyy')
                                      .format(DateTime.now()),
                                  fontSize: FontSize.s20.sp,
                                  color: ColorManager.black,
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: AppSize.s80.h,
                        ),

                        state is CheckInAndOutLoading
                            ? const Center(
                                child: ProgressIndicatorCustom(),
                              )
                            : BlocProvider.value(
                                value: BlocProvider.of<CompaniesCubit>(context)
                                  ..getCompanyFun(),
                                child: BlocConsumer<CompaniesCubit,
                                    CompaniesState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return state is GetCompanySuccess
                                        ? InkWell(
                                            onTap: () async {
                                              // await homeCubit.punchInOutFun();
                                              homeCubit.lat = double.parse(state
                                                  .companiesEntity
                                                  .resultEntity
                                                  .response[0]
                                                  .lat);
                                              homeCubit.long = double.parse(
                                                  state
                                                      .companiesEntity
                                                      .resultEntity
                                                      .response[0]
                                                      .long);

                                              await homeCubit.checkDistance();

                                              if (homeCubit.checked) {
                                                await homeCubit.punchInOutFun();
                                                Future.delayed(
                                                  const Duration(
                                                      milliseconds: 100),
                                                  () async => await BlocProvider
                                                          .of<AttendanceCubit>(
                                                              context)
                                                      .getAttendanceFun(),
                                                );
                                              } else {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 100),
                                                    () async => navigator(
                                                        context,
                                                        Routes
                                                            .createRequestRoute));
                                              }
                                            },
                                            child: state is CheckInAndOutLoading
                                                ? ShimmerCustom(
                                                    child: SvgPicture.asset(
                                                      IconsAssets.punchinIcon,
                                                    ),
                                                  )
                                                : FadeIn(
                                                    child: BlocProvider.value(
                                                      value: BlocProvider.of<
                                                              AttendanceCubit>(
                                                          context)
                                                        ..getAttendanceFun(),
                                                      child: BlocBuilder<
                                                          AttendanceCubit,
                                                          AttendanceState>(
                                                        builder:
                                                            (context, state) {
                                                          return state
                                                                  is GetAttendanceLoading
                                                              ? const Center(
                                                                  child:
                                                                      ProgressIndicatorCustom(),
                                                                )
                                                              : state
                                                                      is GetAttendanceSuccess
                                                                  ? SvgPicture
                                                                      .asset(
                                                                      state.attendanceEntity.resultEntity.response.isEmpty ||
                                                                              state.attendanceEntity.resultEntity.response.first.checkOut !=
                                                                                  'false'
                                                                          ? IconsAssets
                                                                              .punchinIcon
                                                                          : IconsAssets
                                                                              .punchOutIcon,
                                                                    )
                                                                  : SvgPicture
                                                                      .asset(
                                                                      AppConstants.punchIn !=
                                                                              "false"
                                                                          ? IconsAssets
                                                                              .punchinIcon
                                                                          : IconsAssets
                                                                              .punchOutIcon,
                                                                    );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                          )
                                        : state is GetCompanySuccess
                                            ? const Center(
                                                child:
                                                    ProgressIndicatorCustom(),
                                              )
                                            : ElevatedButtonCustom(
                                                width: AppSize.s100.w,
                                                text: 'Reload',
                                                onPressed: () async {
                                                  await BlocProvider.of<
                                                              CompaniesCubit>(
                                                          context)
                                                      .getCompanyFun();
                                                },
                                              );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
