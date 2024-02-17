import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../create_timeOff/domain/entities/create_timeOff_entity.dart';
import '../../../../notifications/domain/usecases/accept_reject_request_usecase.dart';
import 'accept_reject_timeOff_state.dart';

class AcceptRejectTimeOffCubit extends Cubit<AcceptRejectTimeOffState> {
  final AcceptRejectTimeOffUsecase acceptRejectTimeOffUsecase;

  AcceptRejectTimeOffCubit({required this.acceptRejectTimeOffUsecase})
      : super(AcceptRejectTimeOfftInitial());

  static AcceptRejectTimeOffCubit get(context) => BlocProvider.of(context);

  int leavesId = 0;
  String states = '';

  Future<void> acceptRejectFun() async {
    emit(AcceptRejectTimeOffLoading());
    Either<Failure, CreateTimeOffEntity> response =
        await acceptRejectTimeOffUsecase(AcceptRejectTimeOffParams(
      state: states,
      leavesId: leavesId,
    ));

    emit(response
        .fold((failure) => AcceptRejectTimeOffError(message: failure.message),
            (createTimeOffEntity) {
      return AcceptRejectTimeOffSuccess(
          createTimeOffEntity: createTimeOffEntity);
    }));
  }

  String playerId = '';

  Future<void> handleSendNotification({required String status}) async {
    var notification = OSCreateNotification(
      playerIds: [playerId],
      content: "Your request has been $status",
      heading: "KAIZEN HR",
      iosAttachments: {"id1": 'ic_stat_onesignal_default'},
      androidSound: 'onesignal_default_sound',
      androidSmallIcon: 'ic_stat_onesignal_default',
      androidLargeIcon: 'ic_stat_onesignal_default',
      mutableContent: true,
    );

    await OneSignal.shared.postNotification(notification);
    //
    // this.setState(() {
    //   _debugLabelString = "Sent notification with response: $response";
    // });
  }

  String typeFun(String value) {
    if (value == 'check_in') {
      return 'Punch in';
    } else if (value == 'check_out') {
      return 'Punch out';
    } else if (value == 'holiday') {
      return 'Holiday';
    } else if (value == 'leave_of_request') {
      return 'Leave TimeOff';
    }
    return '';
  }

  String stateFun(String value) {
    if (value == 'in_progress') {
      return 'In Progress';
    } else if (value == 'reject') {
      return 'Rejected';
    } else if (value == 'done') {
      return 'Accepted';
    }
    return '';
  }

  String stateLoansFun(String value) {
    if (value == 'waiting_approval_1') {
      return 'Submitted';
    } else if (value == 'approve') {
      return 'Approved';
    } else if (value == 'draft') {
      return 'Draft';
    } else if (value == 'cancel') {
      return 'Canceled';
    } else if (value == 'refuse') {
      return 'Refused';
    }
    return '';
  }
}
