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
          ..add(TopicGetAllEvent()),
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
          // return const ;
        }
        return const SizedBox();
      },
      listener: (context, state) {},
    );
  }

  mqttBlocConsumer() {
    return;
  }
}
