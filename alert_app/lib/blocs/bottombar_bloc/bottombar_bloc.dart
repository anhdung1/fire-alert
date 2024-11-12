import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottombar_event.dart';
part 'bottombar_state.dart';

class BottombarBloc extends Bloc<BottombarEvent, BottombarState> {
  BottombarBloc() : super(const BottombarInititalState(index: 0)) {
    on<BottombarSelectEvent>(_selectPage);
  }

  FutureOr<void> _selectPage(
      BottombarSelectEvent event, Emitter<BottombarState> emit) {
    emit(BottombarInititalState(index: event.index));
  }
}
