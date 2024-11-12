part of 'login_bloc.dart';

abstract class LoginState {
  final bool isLoading;
  final String? error;
  LoginState({required this.isLoading, this.error});
}

class LoginInitialState extends LoginState {
  LoginInitialState({required super.isLoading});
}

class LoginLoadingState extends LoginState {
  LoginLoadingState({required super.isLoading});
}

class LoginAdminSuccessState extends LoginState {
  LoginAdminSuccessState({required super.isLoading});
}

class LoginUserSuccessState extends LoginState {
  LoginUserSuccessState({required super.isLoading});
}

class LoginFailureState extends LoginState {
  LoginFailureState({required super.error, required super.isLoading});
}
