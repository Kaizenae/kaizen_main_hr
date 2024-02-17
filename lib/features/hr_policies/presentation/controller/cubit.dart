import 'package:Attendace/core/api/end_points.dart';
import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:Attendace/features/hr_policies/data/hr_policies_model.dart';
import 'package:Attendace/features/hr_policies/presentation/controller/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HrPoliciesCubit extends Cubit<HrPoliciesStates> {
  HrPoliciesCubit() : super(HrPoliciesInitState());
  HrPoliciesModel hrPoliciesModel = HrPoliciesModel();
  void getHrPolicies() {
    emit(HrPoliciesLoadingState());
    Dio().get(EndPoints.hrPoliciesPath, data: {
      "jsonrpc": "2.0",
      "params": {
        "company_id": AppConstants.companyId.toString(),
      }
    }).then((value) {
      hrPoliciesModel = HrPoliciesModel.fromJson(value.data);
      emit(HrPoliciesSuccessState());
    }).catchError((error) {
      emit(HrPoliciesErrorState());
    });
  }
}
