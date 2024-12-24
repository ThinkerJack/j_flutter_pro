// lib/router/router.dart
import 'package:flutter/material.dart';

import 'core/route_delegate.dart';
import 'core/route_information_parser.dart';
import 'core/route_stack.dart';
import 'core/route_types.dart';

// lib/router/router.dart
// lib/router/router.dart
class AppRouter {
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;

  late final RouteStack _stack;
  late final AppRouterDelegate _delegate;
  late final GlobalKey<NavigatorState> _navigatorKey;
  late final AppRouteInformationParser _parser;

  AppRouter._internal() {
    _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'AppRouter');
    _stack = RouteStack(navigatorKey: _navigatorKey);
    _delegate = AppRouterDelegate(
      stack: _stack,
      navigatorKey: _navigatorKey,
    );
    _parser = AppRouteInformationParser();
  }

  void initialize({
    required List<RouteConfig> routes,
    String initialRoute = '/',
  }) {
    _stack.addRoutes(routes);
    _stack.setInitialRoute(initialRoute);
  }


  RouterDelegate<String> get delegate => _delegate;
  RouteInformationParser<String> get parser => _parser;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void registerModule(List<RouteConfig> routes) {
    _stack.addRoutes(routes);
  }

  Future<void> push(String path, {Map<String, dynamic>? params}) async {
    await _stack.push(path, params: params);
  }

  void pop() {
    _stack.pop();
  }
}