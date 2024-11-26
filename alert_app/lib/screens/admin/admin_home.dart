import 'package:alert_app/blocs/mqtt_bloc/mqtt_bloc.dart';
import 'package:alert_app/blocs/topic_bloc/topic_bloc.dart';
import 'package:alert_app/constant/colors_widget.dart';
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
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      width: screenWidth,
      height: screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            if (mqttState is MqttConnectingState) {
              return Expanded(
                child: Center(
                  child: Container(
                    width: 300,
                    height: 130,
                    padding: const EdgeInsets.all(
                        16.0), // Tạo khoảng cách đều xung quanh nội dung
                    decoration: BoxDecoration(
                      color: ColorsWidget.iconColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 4, // Tạo hiệu ứng bóng mềm hơn
                          offset: Offset(2, 2), // Tăng chiều sâu
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Căn giữa nội dung bên trong
                      children: [
                        Text(
                          "Đang kết nối tới MQTT",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold), // Tăng kích thước chữ
                          textAlign: TextAlign.center, // Canh giữa văn bản
                        ),
                        SizedBox(
                            height:
                                16), // Thêm khoảng cách giữa Text và CircularProgressIndicator
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (mqttState is MqttConnectionFailure) {
              return Center(
                child: Text(mqttState.error),
              );
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
