import 'dart:async';

import 'package:alert_app/models/user_model.dart';
import 'package:alert_app/repositories/profile_repository.dart';
import 'package:alert_app/services/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc(this.profileRepository) : super(ProfileInitialState()) {
    on<ProfileStartedEvent>(_getUser);
    on<ProfileUpdateEvent>(_updateUser);
  }

  FutureOr<void> _getUser(
      ProfileStartedEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    Result<UserModel> result = await profileRepository.getUser();
    if (result.isSuccess) {
      return emit(ProfileSuccessState(user: result.data!));
    }
    return emit(ProfileFailureState(error: result.error ?? ""));
  }

  FutureOr<void> _updateUser(
      ProfileUpdateEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    Result<UserModel> result =
        await profileRepository.updateUser(event.updateUser);

    if (result.isSuccess) {
      return emit(ProfileUpdateSuccessState());
    }
    return emit(ProfileFailureState(error: result.error ?? ""));
  }
}
