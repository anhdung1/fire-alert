import 'package:alert_app/blocs/mqtt_bloc/mqtt_bloc.dart';
import 'package:alert_app/blocs/topic_bloc/topic_bloc.dart';
import 'package:alert_app/repositories/mqtt_repository.dart';
import 'package:alert_app/repositories/profile_repository.dart';

import 'package:alert_app/services/mqtt_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => MqttService()),
        RepositoryProvider(
          create: (context) =>
              MqttRepository(mqttService: context.read<MqttService>()),
        )
      ],
      child: BlocProvider(
        create: (context) => TopicBloc(context.read<ProfileRepository>())
          ..add(TopicStartedEvent()),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopicBloc, TopicState>(
      builder: (context, state) {
        if (state is TopicSuccessState) {
          return mqttBlocConsumer(state);
        }
        return const SizedBox();
      },
      listener: (context, state) {},
    );
  }

  mqttBlocConsumer(TopicSuccessState topicState) {
    return BlocProvider(
      create: (context) => MqttBloc(context.read<MqttRepository>())
        ..add(MqttConnectEvent(sensors: topicState.sensors)),
      child: Builder(builder: (context) {
        return BlocConsumer<MqttBloc, MqttState>(
          builder: (context, mqttState) {
            if (mqttState is MqttReceivedState) {}
            return const SizedBox();
          },
          listener: (context, mqttState) {},
        );
      }),
    );
  }
}
