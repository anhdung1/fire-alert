part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final AlertModel alertModel;

  SearchSuccessState({required this.alertModel});
}

class SearchFailureState extends SearchState {
  final String error;

  SearchFailureState({required this.error});
}
