abstract class RequestsStates {}

class RequestInitState extends RequestsStates {}

class RequestLoadingState extends RequestsStates {}

class RequestSuccessState extends RequestsStates {}

class RequestErrorState extends RequestsStates {}

class ApproveRequestLoadingState extends RequestsStates {}

class ApproveRequestSuccessState extends RequestsStates {
  final String message;
  ApproveRequestSuccessState({required this.message});
}

class ApproveRequestErrorState extends RequestsStates {
  final String message;
  ApproveRequestErrorState({required this.message});
}

class RejectRequestLoadingState extends RequestsStates {}

class RejectRequestSuccessState extends RequestsStates {
  final String message;
  RejectRequestSuccessState({required this.message});
}

class RejectRequestErrorState extends RequestsStates {
  final String message;
  RejectRequestErrorState({required this.message});
}

class CannotOpenFileState extends RequestsStates {
  final String message;
  CannotOpenFileState({required this.message});
}

class AppChangeBottomSheetState extends RequestsStates {}
