part of 'topic_bloc.dart';

abstract class TopicState {}

class TopicInitalState extends TopicState {}

class TopicLoadingState extends TopicState {}

class TopicSuccessState extends TopicState {
  final List<SensorResponse> sensors;

  TopicSuccessState({required this.sensors});
}

class TopicFailureState extends TopicState {
  final String error;

  TopicFailureState({required this.error});
}
