import 'package:flutter/material.dart';
import 'package:router/core/route_stack.dart';

class AppRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  final RouteStack stack;
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate({
    required this.stack,
    required this.navigatorKey,
  }) {
    stack.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    List<Page> pages = stack.pages;
    if (pages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        stack.pop();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {
    await stack.push(configuration);
  }
}