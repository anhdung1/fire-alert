part of 'logout_bloc.dart';

abstract class LogoutState {
  bool? isLoading = false;
}

class LogoutInitialState extends LogoutState {
  @override
  bool get isLoading => false;
}

class LogoutLoadingState extends LogoutState {
  @override
  bool get isLoading => true;
}

class LogoutSuccessState extends LogoutState {
  @override
  bool get isLoading => false;
}
