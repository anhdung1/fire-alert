import 'dart:async';

import 'package:alert_app/models/alert_model.dart';
import 'package:alert_app/repositories/alert_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AlertRepository alertRepository;
  SearchBloc(this.alertRepository) : super(SearchInitialState()) {
    on<SearchSubmitEvent>(_search);
  }

  FutureOr<void> _search(SearchSubmitEvent event, Emitter<SearchState> emit) {}
}
