import 'dart:async';

import 'package:alert_app/services/profile_service.dart';
import 'package:alert_app/services/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'topic_state.dart';
part 'topic_event.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final ProfileService profileService;
  TopicBloc(this.profileService) : super(TopicInitalState()) {
    on<TopicStartedEvent>(_getTopic);
  }

  FutureOr<void> _getTopic(
      TopicStartedEvent event, Emitter<TopicState> emit) async {
    Result<List<String>> result = await profileService.getTopic();
    if (result.isSuccess) {
      return emit(TopicSuccessState(topic: result.data!));
    }
    return emit(TopicFailureState(error: result.error!));
  }
}
