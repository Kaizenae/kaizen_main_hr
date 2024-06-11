abstract class OvertimeStates {}

class OvertimeInitState extends OvertimeStates {}

class GetOvertimeLoadingState extends OvertimeStates {}

class GetOvertimeErrorState extends OvertimeStates {}

class GetOvertimeSuccessState extends OvertimeStates {}

class CreateOvertimeLoadingState extends OvertimeStates {}

class CreateOvertimeErrorState extends OvertimeStates {
  final String message;
  CreateOvertimeErrorState({required this.message});
}

class CreateOvertimeSuccessState extends OvertimeStates {
  final String message;
  CreateOvertimeSuccessState({required this.message});
}

class ChangeDateState extends OvertimeStates {}

class ChangeTimeState extends OvertimeStates {}

class CancelMyRequestSuccessState extends OvertimeStates {
  final String message;

  CancelMyRequestSuccessState({required this.message});
}

class CancelMyRequestErrorState extends OvertimeStates {
  final String message;

  CancelMyRequestErrorState({required this.message});
}

class CancelMyRequestLoadingState extends OvertimeStates {}
