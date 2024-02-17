import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:Attendace/features/myLoans/presentation/controller/myLoans_state.dart';
import 'package:Attendace/features/notifications/presentation/controllers/accept_reject_request/accept_reject_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../controller/myLoans_cubit.dart';
import 'userRequest_widget.dart';

class ApprovedWidget extends StatelessWidget {
  const ApprovedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyLoansCubit>(context)..getMyLoansFun(),
      child: BlocConsumer<MyLoansCubit, MyLoansState>(
        listener: (context, state) {},
        builder: (context, state) {
          var loansCubit = MyLoansCubit.get(context);
          return state is GetMyLoansSuccess
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(AppPadding.p12.r),
                    child: Column(
                      children: [
                        UserRequestWidget(
                          iconPath: IconsAssets.emailIcon,
                          text: AppStrings.message,
                          subText: state.myLoansEntity.resultEntity
                              .response[index].employeeId,
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.calenderIcon,
                          text: AppStrings.date,
                          subText: DateFormat('EEE, MMM dd, yyyy').format(
                              DateTime.parse(
                                  loansCubit.myLoans[index].loanDate)),
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.distanceIcon,
                          text: AppStrings.distance,
                          subText:
                              '${loansCubit.myLoans[index].loanAmount} ${loansCubit.myLoans[index].currencyId}',
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.clockIcon,
                          text: AppStrings.status,
                          subText: AcceptRejectRequestCubit.get(context)
                              .stateLoansFun(
                                  loansCubit.myLoans[index].loanState),
                        ),
                      ],
                    ),
                  ),
                  itemCount: loansCubit.myLoans.length,
                )
              : state is GetMyLoansLoading
                  ? ShimmerCustom(
                      child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => const Column(
                        children: [
                          UserRequestWidget(
                            iconPath: IconsAssets.emailIcon,
                            text: AppStrings.message,
                            subText: 'Loading.......',
                          ),
                          UserRequestWidget(
                            iconPath: IconsAssets.calenderIcon,
                            text: AppStrings.date,
                            subText: 'Loading.......',
                          ),
                          UserRequestWidget(
                            iconPath: IconsAssets.clockIcon,
                            text: AppStrings.time,
                            subText: 'Loading.......',
                          ),
                          UserRequestWidget(
                            iconPath: IconsAssets.distanceIcon,
                            text: AppStrings.distance,
                            subText: ' Loading.......',
                          ),
                        ],
                      ),
                      itemCount: 2,
                    ))
                  : ErrorsWidget(
                      onPress: () {
                        BlocProvider.of<MyLoansCubit>(context).getMyLoansFun();
                      },
                    );
        },
      ),
    );
  }
}
