import 'dart:async';

import 'package:alert_app/local/preference_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logout_state.dart';
part 'logout_event.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitialState()) {
    on<LogoutSubmitEvent>(_logout);
  }

  FutureOr<void> _logout(
      LogoutSubmitEvent event, Emitter<LogoutState> emit) async {
    emit(LogoutLoadingState());
    await PreferenceHelper.removeApiKey();
    emit(LogoutSuccessState());
  }
}
