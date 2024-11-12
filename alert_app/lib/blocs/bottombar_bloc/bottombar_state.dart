part of 'bottombar_bloc.dart';

abstract class BottombarState extends Equatable {
  final int index;

  const BottombarState({required this.index});
  @override
  List<Object?> get props => [];
}

class BottombarInititalState extends BottombarState {
  const BottombarInititalState({required super.index});

  @override
  List<Object?> get props => [index];
}
