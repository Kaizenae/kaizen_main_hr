import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/presentation/screens/profile_component.dart';
import '../cubit/edit_company_cubit.dart';
import '../cubit/edit_company_state.dart';

class EditCompanyScreen extends StatelessWidget {
  const EditCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'Edit Company',
      ),
      body: BlocConsumer<EditCompanyCubit, EditCompanyStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var companyCubit = EditCompanyCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ProfileComponent(
                    iconName: companyCubit.profileIconName[index],
                    name: companyCubit.profileNames[index],
                    screen: companyCubit.screenNames[index]),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: companyCubit.profileNames.length),
          );
        },
      ),
    );
  }
}
