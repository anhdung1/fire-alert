part of 'topic_bloc.dart';

abstract class TopicEvent {}

class TopicStartedEvent extends TopicEvent {}

class TopicGetAllEvent extends TopicEvent {}
