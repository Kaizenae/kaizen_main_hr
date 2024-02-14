import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/cached_image_custom/cached_network_image.dart';
import '../../../../core/widgets/component.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'profile_component.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: AppSize.s16.h,
          ),
          BlocProvider.value(
            value: BlocProvider.of<ProfileCubit>(context)..getEmployeeFun(),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is GetEmployeeError) {
                  showToast(message: state.message, color: ColorManager.error);
                }
                if (state is LogoutState) {
                  navigatorAndRemove(context, Routes.loginRoute);
                }
              },
              builder: (context, state) {
                return state is GetEmployeeSuccess
                    ? Column(
                        children: [
                          CircleAvatar(
                            radius: AppSize.s30.r,
                            backgroundColor: ColorManager.scaffoldColor,
                            child: const CachedNetworkImageCustom(
                              url:
                                  'https://res.cloudinary.com/halqetelzekr/image/upload/v1678732276/placeholder_t7jyyi.png',
                            ),
                          ),
                          TextCustom(
                            text: state
                                .employeeEntity.resultEntity.response[0].name,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.s22.sp,
                            color: ColorManager.black,
                          ),
                          SizedBox(
                            height: AppSize.s16.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(AppPadding.p8.r / 2),
                            decoration: BoxDecoration(
                                color: ColorManager.textBackgroundColor,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10.r)),
                            child: TextCustom(
                              text: state.employeeEntity.resultEntity
                                  .response[0].email,
                              fontSize: FontSize.s12.sp,
                              color: ColorManager.grey2,
                            ),
                          ),
                          SizedBox(
                            height: AppSize.s16.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(AppPadding.p8.r / 2),
                            decoration: BoxDecoration(
                                color: ColorManager.textBackgroundColor,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10.r)),
                            child: TextCustom(
                              text: state.employeeEntity.resultEntity
                                  .response[0].salary,
                              fontSize: FontSize.s12.sp,
                              color: ColorManager.grey2,
                            ),
                          ),
                          SizedBox(
                            height: AppSize.s20.h,
                          ),
                          TextCustom(
                            text: state.employeeEntity.resultEntity.response[0]
                                .mobilePhone,
                            fontSize: FontSize.s12.sp,
                            color: ColorManager.primary,
                          ),
                        ],
                      )
                    : state is GetEmployeeLoading
                        ? ShimmerCustom(
                            child: Column(
                            children: [
                              const CircleAvatar(
                                radius: AppSize.s30,
                                backgroundColor: ColorManager.primary,
                              ),
                              TextCustom(
                                text: 'Kaizen',
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.s22,
                                color: ColorManager.black,
                              ),
                              const SizedBox(
                                height: AppSize.s16,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.all(AppPadding.p8 / 2),
                                decoration: BoxDecoration(
                                    color: ColorManager.textBackgroundColor,
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s10.r)),
                                child: TextCustom(
                                  text: 'xxx@xx.com',
                                  fontSize: FontSize.s12,
                                  color: ColorManager.grey2,
                                ),
                              ),
                              const SizedBox(
                                height: AppSize.s20,
                              ),
                              TextCustom(
                                text: '+201000000000',
                                fontSize: FontSize.s12,
                                color: ColorManager.primary,
                              ),
                            ],
                          ))
                        : ErrorsWidget(
                            onPress: () {
                              BlocProvider.of<ProfileCubit>(context)
                                  .getEmployeeFun();
                            },
                          );
              },
            ),
          ),
          SizedBox(
            height: AppSize.s20.h,
          ),
          Container(
            padding: EdgeInsets.all(AppPadding.p12.r),
            decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s10.r)),
            child: const Column(
              children: [
                ProfileComponent(
                  iconName: IconsAssets.personIcon,
                  name: AppStrings.editProfile,
                  screen: Routes.editProfileRoute,
                ),
                Divider(),
                ProfileComponent(
                  iconName: IconsAssets.attendIcon,
                  name: AppStrings.myRequests,
                  screen: Routes.myRequestsRoute,
                ),
                Divider(),
                ProfileComponent(
                  iconName: IconsAssets.attendIcon,
                  name: AppStrings.myLoans,
                  screen: Routes.myLoansRoute,
                ),
                Divider(),
                ProfileComponent(
                  iconName: IconsAssets.attendIcon,
                  name: AppStrings.myTimeOff,
                  screen: Routes.myTimeOffRoute,
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s18.h,
          ),
          Container(
            padding: EdgeInsets.all(AppPadding.p12.r),
            decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s10.r)),
            child: Column(
              children: [
                const ProfileComponent(
                  iconName: IconsAssets.lockIcon,
                  name: AppStrings.changePassword,
                  screen: Routes.changePasswordRoute,
                ),
                const Divider(),
                AppConstants.admin
                    ? const ProfileComponent(
                        iconName: IconsAssets.notificationIcon,
                        name: AppStrings.notifications,
                        screen: Routes.notificationsRoute,
                      )
                    : const SizedBox(),
                const Divider(),
                AppConstants.admin
                    ? const ProfileComponent(
                        iconName: IconsAssets.homeIcon,
                        name: AppStrings.updateCompany,
                        screen: Routes.editCompanyRoute,
                      )
                    : const SizedBox(),
                // Divider(),
                // ProfileComponent(
                //   iconName: IconsAssets.settingIcon,
                //   name: AppStrings.settings,
                //   screen: Routes.settingsRoute,
                // ),
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s18.h,
          ),
          Container(
            padding: EdgeInsets.all(AppPadding.p12.r),
            decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s10.r)),
            child: const Column(
              children: [
                ProfileComponent(
                  iconName: IconsAssets.shieldTickIcon,
                  name: AppStrings.privacyPolicy,
                  screen: Routes.webViewExampleRoute,
                ),
                Divider(),
                ProfileComponent(
                  iconName: IconsAssets.attendIcon,
                  name: AppStrings.termsConditions,
                  screen: '',
                ),
                Divider(),
                ProfileComponent(
                  iconName: IconsAssets.messageQuestionIcon,
                  name: AppStrings.helpsFeedback,
                  screen: Routes.helpRoute,
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s20.h,
          ),
          TextButton(
              onPressed: () async {
                await ProfileCubit.get(context).logout(context);
              },
              child: TextCustom(
                text: 'Logout',
                fontSize: FontSize.s16.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.error,
              ))
        ],
      ),
    );
  }
}
