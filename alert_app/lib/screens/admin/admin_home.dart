import 'package:alert_app/blocs/mqtt_bloc/mqtt_bloc.dart';
import 'package:alert_app/blocs/topic_bloc/topic_bloc.dart';
import 'package:alert_app/repositories/mqtt_repository.dart';
import 'package:alert_app/repositories/profile_repository.dart';
import 'package:alert_app/services/mqtt_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

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
          ..add(TopicGetAllEvent()),
        child: const AdminHomePage(),
      ),
    );
  }
}

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});
  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopicBloc, TopicState>(
      builder: (context, topicState) {
        if (topicState is TopicSuccessState) {
          return mqttBlocConsumer(topicState);
        }

        return const SizedBox();
      },
      listener: (context, topicState) {},
    );
  }

  mqttBlocConsumer(TopicSuccessState topicState) {
    return BlocProvider(
      create: (context) => MqttBloc(context.read<MqttRepository>())
        ..add(MqttConnectEvent(sensors: topicState.sensors)),
      child: Builder(builder: (context) {
        return BlocConsumer<MqttBloc, MqttState>(
          builder: (context, mqttState) {
            if (mqttState is MqttConnectedState) {
              return const Column(
                children: [],
              );
            }
            return const SizedBox();
          },
          listener: (context, mqttState) {},
        );
      }),
    );
  }
}
