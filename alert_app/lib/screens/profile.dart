import 'package:alert_app/blocs/logout_bloc/logout_bloc.dart';
import 'package:alert_app/blocs/profile_bloc/profile_bloc.dart';
import 'package:alert_app/constant/colors_widget.dart';
import 'package:alert_app/constant/constant.dart';
import 'package:alert_app/constant/widget.dart';
import 'package:alert_app/repositories/profile_repository.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late double screenWidth;
  late double screenHeight;
  pushToInfomationPage() {
    Navigator.pushNamed(context, '/infomation');
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) =>
                ProfileService(apiService: context.read<ApiService>()),
          ),
          RepositoryProvider(
            create: (context) => ProfileRepository(
                profileService: context.read<ProfileService>()),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    ProfileBloc(context.read<ProfileRepository>())
                      ..add(ProfileStartedEvent())),
          ],
          child: BlocConsumer<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileSuccessState) {}
              return profileDefaultState(state);
            },
            listener: (context, state) {},
          ),
        ));
  }

  profileDefaultState(ProfileState state) {
    return Builder(builder: (context) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: Constant.fontSizeTitle(screenHeight),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Icon(
                  Icons.account_circle,
                  size: screenHeight / 6,
                  color: Colors.black26,
                ),
                Text(
                  state.user != null ? state.user!.name : "Lỗi tải tên",
                  style: TextStyle(
                      fontSize: screenWidth / 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  state.user != null ? state.user!.email : "Lỗi tải email",
                  style: TextStyle(
                      fontSize: screenWidth / 22, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 5,
                ),
                profileItem(() {
                  pushToInfomationPage();
                }, Icons.person, "Infomation"),
                profileItem(() {}, Icons.settings, "Setting"),
                profileItem(
                    () {}, Icons.notifications_sharp, "Push Notifications"),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                ),
                profileItem(() {}, Icons.support, "Support"),
                profileItem(() {
                  context.read<LogoutBloc>().add(LogoutSubmitEvent());
                }, Icons.logout_outlined, "Logout"),
              ],
            ),
          ),
          if (state.isLoading) loading()
        ],
      );
    });
  }

  profileItem(Function() onTap, IconData icon, String nameButton) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: screenWidth,
          height: screenHeight / 15,
          decoration: BoxDecoration(
              color: ColorsWidget.backgroundColorItemButton,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                height: screenHeight / 22,
                width: screenHeight / 22,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenHeight / 40)),
                child: Icon(
                  icon,
                  size: screenHeight / 30,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                nameButton,
                style: TextStyle(fontSize: screenHeight / 43.5),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.navigate_next_rounded,
                  size: screenHeight / 40,
                ),
              )),
              const SizedBox(
                width: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
