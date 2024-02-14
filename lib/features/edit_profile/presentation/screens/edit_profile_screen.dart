import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/presentation/screens/profile_component.dart';
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
          listener: (context, state) {},
          builder: (context, state) {
            var profileCubit = EditProfileCubit.get(context);
            return Padding(
              padding: EdgeInsets.all(AppPadding.p20.r),
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ProfileComponent(
                      iconName: profileCubit.profileIconName[index],
                      name: profileCubit.profileNames[index],
                      screen: profileCubit.screenNames[index]),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: profileCubit.profileNames.length),
            );
          },
        ),
      ),
    );
  }
}
