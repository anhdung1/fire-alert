part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileStartedEvent extends ProfileEvent {}

class ProfileUpdateEvent extends ProfileEvent {
  final UserModel updateUser;

  ProfileUpdateEvent({required this.updateUser});
}
