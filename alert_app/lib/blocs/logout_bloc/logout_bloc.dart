import 'dart:async';

import 'package:alert_app/local/preference_helper.dart';
import 'package:alert_app/repositories/device_token_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logout_state.dart';
part 'logout_event.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final DeviceTokenRepository deviceTokenRepository;
  LogoutBloc(this.deviceTokenRepository) : super(LogoutInitialState()) {
    on<LogoutSubmitEvent>(_logout);
  }

  FutureOr<void> _logout(
      LogoutSubmitEvent event, Emitter<LogoutState> emit) async {
    emit(LogoutLoadingState());
    await deviceTokenRepository.deleteDeviceToken();
    await PreferenceHelper.removeLoginStatus();
    emit(LogoutSuccessState());
  }
}
