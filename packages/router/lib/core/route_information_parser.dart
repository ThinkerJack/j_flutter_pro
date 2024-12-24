import 'package:flutter/material.dart';

class AppRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) async {
    final location = routeInformation.location;
    if (location == null) return '/';

    // 处理 URI 编码的路径
    final uri = Uri.parse(location);
    String path = uri.path;

    // 确保路径以 / 开头
    if (!path.startsWith('/')) {
      path = '/$path';
    }

    // 如果是根路径，直接返回
    if (path == '/') return path;

    // 移除末尾的 /
    if (path.endsWith('/') && path.length > 1) {
      path = path.substring(0, path.length - 1);
    }

    return path;
  }

  @override
  RouteInformation? restoreRouteInformation(String configuration) {
    return RouteInformation(location: configuration);
  }
}