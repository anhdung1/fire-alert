import 'package:alert_app/blocs/bottombar_bloc/bottombar_bloc.dart';
import 'package:alert_app/blocs/logout_bloc/logout_bloc.dart';
import 'package:alert_app/constant/colors_widget.dart';
import 'package:alert_app/constant/widget.dart';
import 'package:alert_app/repositories/profile_repository.dart';
import 'package:alert_app/screens/admin/admin_home.dart';
import 'package:alert_app/screens/profile.dart';
import 'package:alert_app/screens/shared/chat.dart';

import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminMyHome extends StatefulWidget {
  const AdminMyHome({super.key});

  @override
  State<AdminMyHome> createState() => _AdminMyHomeState();
}

class _AdminMyHomeState extends State<AdminMyHome> {
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
    BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: "Chat"),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              ProfileService(apiService: context.read<ApiService>()),
        ),
        RepositoryProvider(
          create: (context) =>
              ProfileRepository(profileService: context.read<ProfileService>()),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BottombarBloc(),
          ),
          BlocProvider(create: (context) => LogoutBloc())
        ],
        child: Builder(
          builder: (context) {
            return BlocBuilder<BottombarBloc, BottombarState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    Scaffold(
                      body: IndexedStack(
                        index: state.index == 0 ? 0 : 1,
                        children: [
                          const AdminHome(),
                          if (state.index == 1) const Profile(),
                          if (state.index == 2) const Chat(),
                        ],
                      ),
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
                          Navigator.pushNamedAndRemoveUntil(context, "/login",
                              (Route<dynamic> route) => false);
                        }
                      },
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
