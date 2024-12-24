// packages/user/lib/routes/user_routes.dart
import 'package:flutter/material.dart';
import 'package:router/core/route_types.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';

class UserRoutes {
  static final routes = [
    RouteConfig(
      path: '/user/profile',
      name: 'user_profile',
      builder: (context, params) => ProfilePage(
        userId: params?['id'] as String?,
      ),
    ),
    RouteConfig(
      path: '/user/settings',
      name: 'user_settings',
      builder: (context, params) => const SettingsPage(),
    ),
  ];
}