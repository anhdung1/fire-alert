part of 'topic_bloc.dart';

abstract class TopicState {}

class TopicInitalState extends TopicState {}

class TopicLoadingState extends TopicState {}

class TopicSuccessState extends TopicState {
  final List<String> topic;

  TopicSuccessState({required this.topic});
}

class TopicFailureState extends TopicState {
  final String error;

  TopicFailureState({required this.error});
}
