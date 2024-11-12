part of 'profile_bloc.dart';

abstract class ProfileState {
  final UserModel? user;
  bool isLoading = true;

  ProfileState({this.user});
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {
  @override
  bool get isLoading => true;
}

class ProfileSuccessState extends ProfileState {
  @override
  bool get isLoading => false;
  ProfileSuccessState({super.user});
}

class ProfileUpdateSuccessState extends ProfileState {}

class ProfileFailureState extends ProfileState {
  @override
  bool get isLoading => false;
  final String error;

  ProfileFailureState({required this.error, super.user});
}
