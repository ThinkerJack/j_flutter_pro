import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:router/core/route_types.dart';

class RouteStack extends ChangeNotifier {
  final List<Page> _pages = [];
  final Map<String, RouteConfig> _routes = {};
  final GlobalKey<NavigatorState> navigatorKey;

  RouteStack({required this.navigatorKey});

  List<Page> get pages => List.unmodifiable(_pages);

  void addRoute(RouteConfig config) {
    if (!_routes.containsKey(config.path)) {
      _routes[config.path] = config;
    }
  }

  void addRoutes(List<RouteConfig> routes) {
    for (var route in routes) {
      addRoute(route);
    }
  }

  void setInitialRoute(String path) {
    final route = _routes[path];
    if (route == null) return;

    if (_pages.isEmpty) {
      _pages.add(MaterialPage(
        key: UniqueKey(),
        name: path,
        child: Builder(
          builder: (context) => route.builder(context, null),
        ),
      ));
      notifyListeners();
    }
  }

  Future<void> push(String path, {Map<String, dynamic>? params}) async {
    final route = _routes[path];
    if (route == null) return;

    // debug模式下检查是否为栈底的重复路由
    if (kDebugMode && _pages.length == 1 && _pages.first.name == path) {
      return;
    }

    _pages.add(MaterialPage(
      key: UniqueKey(),
      name: path,
      arguments: params,
      child: Builder(
        builder: (context) => route.builder(context, params),
      ),
    ));
    notifyListeners();
  }

  void pop() {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
    }
  }

  String? get currentPath => _pages.isNotEmpty ? _pages.last.name : null;

  int get stackSize => _pages.length;

  bool get canPop => _pages.length > 1;
}