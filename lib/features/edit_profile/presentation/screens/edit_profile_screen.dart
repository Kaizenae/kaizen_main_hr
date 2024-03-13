import 'package:animate_do/animate_do.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../cubit/edit_profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'Edit Profile',
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<EditProfileCubit>(context),
        child: BlocConsumer<EditProfileCubit, EditProfileStates>(
          listener: (context, state) {
            if (state is EditUserPhotoSuccessState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.message),
                duration: Duration(
                  seconds: AppConstants.snackBarTime,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              ProfileCubit.get(context).getEmployeeFun();
            } else if (state is EditUserPhotoErrorState) {
              SnackBar snackBar = SnackBar(
                content: const Text("Some thing went wrong, Try again later"),
                duration: Duration(
                  seconds: AppConstants.snackBarTime,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            var profileCubit = EditProfileCubit.get(context);
            return Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Column(
                  children: [
                    // const ProfileComponent(
                    //   name: AppStrings.changeUserName,
                    //   iconName: IconsAssets.personIcon,
                    //   screen: Routes.editUserNameRoute,
                    // ),
                    // const Divider(),
                    // const ProfileComponent(
                    //   name: AppStrings.changePhoneNumber,
                    //   iconName: IconsAssets.phoneIcon,
                    //   screen: Routes.editPhoneNumberRoute,
                    // ),
                    // const Divider(),
                    SlideInLeft(
                      child: InkWell(
                        onTap: () {
                          profileCubit.getProfileImage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p6),
                          child: Row(
                            children: [
                              const SvgPictureCustom(
                                assetsName: IconsAssets.personIcon,
                                color: ColorManager.skyColor,
                              ),
                              const SizedBox(
                                width: AppSize.s16,
                              ),
                              TextCustom(
                                text: AppStrings.editUserPhoto,
                                fontWeight: FontWeight.w200,
                                fontSize: FontSize.s16,
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}
