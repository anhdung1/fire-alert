part of 'bottombar_bloc.dart';

abstract class BottombarEvent {}

class BottombarSelectEvent extends BottombarEvent {
  final int index;

  BottombarSelectEvent({required this.index});
}
