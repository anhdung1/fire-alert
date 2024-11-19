import 'dart:async';

import 'package:alert_app/local/database_helper.dart';
import 'package:alert_app/models/sensor_response.dart';
import 'package:alert_app/repositories/profile_repository.dart';
import 'package:alert_app/services/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'topic_state.dart';
part 'topic_event.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final ProfileRepository profileRepository;
  TopicBloc(this.profileRepository) : super(TopicInitalState()) {
    on<TopicStartedEvent>(_getTopic);
    on<TopicGetAllEvent>(_getAllTopic);
  }

  FutureOr<void> _getTopic(
      TopicStartedEvent event, Emitter<TopicState> emit) async {
    Result<List<SensorResponse>> result = await profileRepository.getTopic();
    if (result.isSuccess) {
      return emit(TopicSuccessState(sensors: result.data!));
    }
    return emit(TopicFailureState(error: result.error!));
  }

  FutureOr<void> _getAllTopic(
      TopicGetAllEvent event, Emitter<TopicState> emit) async {
    List<Map<String, dynamic>> sensorsMap =
        await DatabaseHelper.instance.queryAllSensors();

    try {
      if (sensorsMap.isNotEmpty) {
        List<SensorResponse> sensors = [];
        for (int i = 0; i < sensorsMap.length; i++) {
          SensorResponse sensor = SensorResponse.fromJson(sensorsMap[i]);
          sensors.add(sensor);
        }
        return emit(TopicSuccessState(sensors: sensors));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    Result<List<SensorResponse>> result = await profileRepository.getAllTopic();

    if (result.isSuccess) {
      return emit(TopicSuccessState(sensors: result.data!));
    }
    return emit(TopicFailureState(error: result.error!));
  }
}
