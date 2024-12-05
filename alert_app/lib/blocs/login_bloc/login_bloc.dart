import 'dart:async';

import 'package:alert_app/models/login_response.dart';
import 'package:alert_app/repositories/device_token_repository.dart';
import 'package:alert_app/repositories/login_repository.dart';

import 'package:alert_app/services/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "login_event.dart";
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final DeviceTokenRepository deviceTokenRepository;
  LoginBloc(this.loginRepository, this.deviceTokenRepository)
      : super(LoginInitialState(isLoading: false)) {
    on<LoginSubmitEvent>(_login);
  }

  FutureOr<void> _login(
      LoginSubmitEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState(isLoading: true));
    Result<LoginResponse> result =
        await loginRepository.login(event.username, event.password);
    if (result.isSuccess) {
      await deviceTokenRepository.sendDeviceInfo();
      if (result.data!.role == "ROLE_USER") {
        return emit(LoginUserSuccessState(isLoading: false));
      }
      return emit(LoginAdminSuccessState(isLoading: false));
    }
    return emit(LoginFailureState(
        error: result.error ?? "unknow error", isLoading: false));
  }
}
