// lib/main.dart
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:router/route.dart';
import 'package:user/user.dart';

// lib/main.dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final router = AppRouter();

  // 然后初始化
  router.initialize(
    routes: [
      ...HomeRoutes.routes,
      ...UserRoutes.routes,
    ],
    initialRoute: '/',
  );

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      routerDelegate: router.delegate,
      routeInformationParser: router.parser,
    );
  }
}
