abstract class CheckInCheckOutStates {}

class CheckInCheckOutInitState extends CheckInCheckOutStates {}

class CheckInCheckOutLoadingState extends CheckInCheckOutStates {}

class CheckInCheckOutSuccessState extends CheckInCheckOutStates {
  final String message;

  CheckInCheckOutSuccessState({required this.message});
}

class CheckInCheckOutErrorState extends CheckInCheckOutStates {
  final String message;

  CheckInCheckOutErrorState({required this.message});
}

class GetCompanyLocationLoadingState extends CheckInCheckOutStates {}

class GetCompanyLocationSuccessState extends CheckInCheckOutStates {}

class GetCompanyLocationErrorState extends CheckInCheckOutStates {}
