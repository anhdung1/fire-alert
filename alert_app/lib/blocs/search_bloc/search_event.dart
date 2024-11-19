part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchSubmitEvent extends SearchEvent {
  final String dataSearch;

  SearchSubmitEvent({required this.dataSearch});
}
