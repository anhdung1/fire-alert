import 'package:alert_app/blocs/login_bloc/login_bloc.dart';
import 'package:alert_app/local/database_helper.dart';
import 'package:alert_app/local/preference_helper.dart';
import 'package:alert_app/repositories/login_repository.dart';
import 'package:alert_app/screens/admin/admin_my_home.dart';
import 'package:alert_app/screens/shared/infomation.dart';
import 'package:alert_app/screens/shared/login.dart';
import 'package:alert_app/screens/user/my_home.dart';

import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/firebase_messaging_service.dart';
import 'package:alert_app/services/login_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyCk0L6CO0MgGf4QwQ6RCPH5HhjQxZw0MoA",
  //         authDomain: "fire-alarm-4b1a5.firebaseapp.com",
  //         databaseURL: "https://fire-alarm-4b1a5-default-rtdb.firebaseio.com",
  //         projectId: "fire-alarm-4b1a5",
  //         storageBucket: "fire-alarm-4b1a5.firebasestorage.app",
  //         messagingSenderId: "18390664830",
  //         appId: "1:18390664830:web:f2b29715a66b20a077fa2f",
  //         measurementId: "G-21FQK3Q7NM"));

  FirebaseMessagingService firebaseMessagingService =
      FirebaseMessagingService();
  await firebaseMessagingService.setting();
  await firebaseMessagingService.configureFirebase();
  firebaseMessagingService.receivedMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await DatabaseHelper.instance.database;
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
              ? (role == "ROLE_ADMIN" ? const AdminMyHome() : const MyHome())
              : const Login(),
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage data) async {}
