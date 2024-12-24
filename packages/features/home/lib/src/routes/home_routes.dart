// packages/home/lib/routes/home_routes.dart
import 'package:flutter/material.dart';
import 'package:router/core/route_types.dart';
import '../pages/home_page.dart';

class HomeRoutes {
  static final routes = [
    RouteConfig(
      path: '/',
      name: 'home',
      builder: (context, params) => const HomePage(),
    ),
  ];
}