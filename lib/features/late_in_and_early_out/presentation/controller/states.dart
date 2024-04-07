abstract class EarlyOutLateInStates {}

class EarlyOutLateInInitState extends EarlyOutLateInStates {}

class EarlyOutLoadingState extends EarlyOutLateInStates {}

class EarlyOutSuccessState extends EarlyOutLateInStates {
  final String message;

  EarlyOutSuccessState({required this.message});
}

class EarlyOutErrorState extends EarlyOutLateInStates {
  final String message;

  EarlyOutErrorState({required this.message});
}

class LateInLoadingState extends EarlyOutLateInStates {}

class LateInSuccessState extends EarlyOutLateInStates {
  final String message;

  LateInSuccessState({required this.message});
}

class LateInErrorState extends EarlyOutLateInStates {
  final String message;

  LateInErrorState({required this.message});
}

class ChangeSelectedDateState extends EarlyOutLateInStates {}

class ChangeFileNameState extends EarlyOutLateInStates {}

class GetLateInSuccessState extends EarlyOutLateInStates {}

class GetLateInErrorState extends EarlyOutLateInStates {}

class GetLateInLoadingState extends EarlyOutLateInStates {}

class GetEarlyOutLoadingState extends EarlyOutLateInStates {}

class GetEarlyOutSuccessState extends EarlyOutLateInStates {}

class GetEarlyOutErrorState extends EarlyOutLateInStates {}

class ChangeDateState extends EarlyOutLateInStates {}

class CancelMyRequestLoadingState extends EarlyOutLateInStates {}

class CancelMyRequestSuccessState extends EarlyOutLateInStates {
  final String message;

  CancelMyRequestSuccessState({required this.message});
}

class CancelMyRequestErrorState extends EarlyOutLateInStates {
  final String message;

  CancelMyRequestErrorState({required this.message});
}
