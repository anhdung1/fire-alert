import 'package:alert_app/blocs/login_bloc/login_bloc.dart';
import 'package:alert_app/local/preference_helper.dart';
import 'package:alert_app/repositories/login_repository.dart';
import 'package:alert_app/screens/admin/admin_my_home.dart';
import 'package:alert_app/screens/shared/infomation.dart';
import 'package:alert_app/screens/shared/login.dart';
import 'package:alert_app/screens/user/my_home.dart';

import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await PreferenceHelper.getIsLoggedIn();
  final String role = await PreferenceHelper.getRole();
  runApp(MyApp(
    role: role,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.role, required this.isLoggedIn});
  final String role;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ApiService()),
        RepositoryProvider(
          create: (context) =>
              LoginService(apiService: context.read<ApiService>()),
        ),
        RepositoryProvider(
          create: (context) => LoginRepository(
            loginService: context.read<LoginService>(),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => LoginBloc(context.read<LoginRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/home': (context) => const MyHome(),
            '/infomation': (context) => const Infomation(),
            '/login': (context) => const Login()
          },
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent),
          home: isLoggedIn
              ? (role == "ROLE_USER" ? const MyHome() : const AdminMyHome())
              : const Login(),
        ),
      ),
    );
  }
}
