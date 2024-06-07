import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../domain/entities/punchInOut_entity.dart';
import '../../domain/usecases/punchInOut_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PunchInOutUsecase punchInOutUsecase;
  HomeCubit({required this.punchInOutUsecase}) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  Future<void> punchInOutFun() async {
    emit(CheckInAndOutLoading());

    Either<Failure, PunchInOutEntity> response =
        await punchInOutUsecase(EmployeeParams(userId: AppConstants.token));

    emit(response.fold(
        (failure) => CheckInAndOutError(message: failure.message),
        (punchInOutEntity) =>
            CheckInAndOutSuccess(punchInOutEntity: punchInOutEntity)));
  }

  bool serviceEnabled = false;
  TextEditingController messageController = TextEditingController();

  bool checked = false;

  bool flag = false;

  isPunchedFun() async {
    emit(PunchChangeLoading());

    await CacheHelper.put(
        key: AppStrings.punched, value: !(AppConstants.isPunched));
    AppConstants.isPunched = await CacheHelper.get(key: AppStrings.punched);
    flag = AppConstants.isPunched;

    emit(PunchChange());
  }

  bool isPunchIn = false;
  void changePunchInAndPunchOut() {
    emit(ChangePunchAndInPunchOutLoadingState());
    isPunchIn = !isPunchIn;
    emit(ChangePunchAndInPunchOutSuccessState());
  }

  bool isMore = false;
  void changeIsMore() {
    isMore = !isMore;
    emit(ChangeIsMoreState());
  }
}
