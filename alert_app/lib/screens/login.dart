import 'package:alert_app/blocs/login_bloc/login_bloc.dart';
import 'package:alert_app/constant/colors_widget.dart';
import 'package:alert_app/constant/widget.dart';
import 'package:alert_app/screens/user/my_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  late double screenWidth;
  late double screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorsWidget.backgroundColor,
      body: BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) {
          return initialPage(state);
        },
        listener: (context, state) {
          if (state is LoginUserSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHome(),
                ));
          }
          if (state is LoginAdminSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHome(),
                ));
          }
        },
      ),
    );
  }

  login() {
    context.read<LoginBloc>().add(LoginSubmitEvent(
        username: _usernameController.text,
        password: _passwordController.text));
  }

  Widget initialPage(LoginState state) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ScrollConfiguration(
            behavior: behavior(context),
            child: ListView(
              controller: _scrollController,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight / 14, bottom: screenHeight / 30),
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth / 10,
                        height: screenWidth / 10,
                        decoration: BoxDecoration(
                            color: ColorsWidget.iconColor,
                            borderRadius: BorderRadius.circular(7)),
                        child: Icon(
                          Icons.wifi,
                          size: screenWidth / 15,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Fire Alert",
                        style: TextStyle(
                            fontSize: screenWidth / 14,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Text(
                  "SIGN IN",
                  style: TextStyle(
                      fontSize: screenWidth / 20, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(
                    "Welcome to join us",
                    style: TextStyle(
                        fontSize: screenWidth / 28,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                inputText("Username", false, _usernameController),
                paddingBottom(screenHeight / 45),
                inputText("Password", true, _passwordController),
                paddingBottom(screenHeight / 90),
                loginFailureMessage(state.error),
                submitButton(() {
                  login();
                }, screenWidth, "LOGIN")
              ],
            ),
          ),
        ),
        if (state.isLoading) loading()
      ],
    );
  }

  paddingBottom(height) {
    return SizedBox(
      height: height,
    );
  }

  loginFailureMessage(String? error) {
    return error == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 18,
                ),
                const SizedBox(
                  width: 3,
                ),
                Expanded(
                  child: Text(
                    error,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
  }
}
