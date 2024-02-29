import '../../domain/entities/edit_profile_entity.dart';

abstract class EditProfileStates {}

class InitEditProfileState extends EditProfileStates {}

class EditProfileLoadingState extends EditProfileStates {}

class EditProfileSuccessState extends EditProfileStates {
  final EditProfileEntity editProfileEntity;

  EditProfileSuccessState({required this.editProfileEntity});
}

class EditProfileErrorState extends EditProfileStates {
  final String message;

  EditProfileErrorState({required this.message});
}

class EditUserPhotoLoadingState extends EditProfileStates {}

class EditUserPhotoErrorState extends EditProfileStates {}

class EditUserPhotoSuccessState extends EditProfileStates {}
