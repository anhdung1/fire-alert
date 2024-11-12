import 'package:alert_app/blocs/bottombar_bloc/bottombar_bloc.dart';
import 'package:alert_app/blocs/logout_bloc/logout_bloc.dart';
import 'package:alert_app/constant/colors_widget.dart';
import 'package:alert_app/constant/widget.dart';
import 'package:alert_app/screens/profile.dart';
import 'package:alert_app/screens/user/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile")
  ];
  late LogoutBloc logoutBloc;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottombarBloc(),
        ),
        BlocProvider(create: (context) => LogoutBloc())
      ],
      child: Builder(
        builder: (context) {
          logoutBloc = BlocProvider.of<LogoutBloc>(context);
          return BlocBuilder<BottombarBloc, BottombarState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Scaffold(
                    body: [
                      Home(
                        page: state.index.toString(),
                      ),
                      const Profile()
                    ][state.index],
                    bottomNavigationBar: BottomNavigationBar(
                        selectedItemColor: ColorsWidget.iconColor,
                        currentIndex: state.index,
                        items: items,
                        onTap: (value) {
                          context
                              .read<BottombarBloc>()
                              .add(BottombarSelectEvent(index: value));
                        }),
                  ),
                  BlocConsumer<LogoutBloc, LogoutState>(
                    builder: (context, state) {
                      if (state.isLoading!) {
                        return loading();
                      }
                      return const SizedBox();
                    },
                    listener: (context, state) {
                      if (state is LogoutSuccessState) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/login", (Route<dynamic> route) => false);
                      }
                    },
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
