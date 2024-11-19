import 'package:alert_app/blocs/mqtt_bloc/mqtt_bloc.dart';
import 'package:alert_app/blocs/topic_bloc/topic_bloc.dart';
import 'package:alert_app/constant/constant.dart';
import 'package:alert_app/models/alert_response.dart';
import 'package:alert_app/repositories/mqtt_repository.dart';
import 'package:alert_app/repositories/profile_repository.dart';
import 'package:alert_app/screens/shared/search.dart';

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
  final TextEditingController _searchController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  void submitSearch() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Search(dataSearch: _searchController.text.trim()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Text(
            "My Home",
            style: TextStyle(
                fontSize: Constant.fontSizeTitle(screenHeight),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<TopicBloc, TopicState>(
            builder: (context, state) {
              if (state is TopicSuccessState) {
                return mqttBlocConsumer(state);
              }
              return const SizedBox();
            },
            listener: (context, state) {},
          ),
        ],
      ),
    );
  }

  mqttBlocConsumer(TopicSuccessState topicState) {
    return BlocProvider(
      create: (context) => MqttBloc(context.read<MqttRepository>())
        ..add(MqttConnectEvent(sensors: topicState.sensors)),
      child: Builder(builder: (context) {
        return BlocConsumer<MqttBloc, MqttState>(
          builder: (context, mqttState) {
            if (mqttState is MqttReceivedState) {
              return Expanded(
                  child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.2, crossAxisCount: 2),
                itemCount: topicState.sensors.length,
                itemBuilder: (context, index) {
                  return itemGridView(mqttState.alertResponse.toList()[index]);
                },
              ));
            }
            return const SizedBox();
          },
          listener: (context, mqttState) {},
        );
      }),
    );
  }

  itemGridView(AlertResponse alert) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: screenHeight / 3,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "Phòng ${alert.topic.substring(7, 10)}",
              style: TextStyle(
                  fontSize: screenWidth / 22, fontWeight: FontWeight.w700),
            ),
          ),
          text("Nồng độ: ${alert.ppm.toString()} (ppm)"),
          text("Nhiệt độ: ${alert.temperature.toString()} (độ C)"),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text("Trạng thái: "),
              alert.fire
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: screenWidth / 19,
                    )
                  : Icon(
                      Icons.error_rounded,
                      color: Colors.red,
                      size: screenWidth / 19,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  text(String content) {
    return Text(
      content,
      style: TextStyle(
          color: Colors.black,
          fontSize: Constant.fontSizeContent(screenWidth),
          height: 1.8,
          fontWeight: FontWeight.w600),
    );
  }
  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
