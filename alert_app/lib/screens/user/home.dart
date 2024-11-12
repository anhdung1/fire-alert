import 'package:alert_app/blocs/topic_bloc/topic_bloc.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          ProfileService(apiService: context.read<ApiService>()),
      child: BlocProvider(
        create: (context) =>
            TopicBloc(context.read<ProfileService>())..add(TopicStartedEvent()),
        child: Builder(
          builder: (context) => Bloc,
        ),
      ),
    );
  }
}
