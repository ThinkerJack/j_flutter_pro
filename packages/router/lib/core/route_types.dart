// lib/router/core/route_types.dart
import 'package:flutter/material.dart';

typedef RouteBuilder = Widget Function(BuildContext context, Map<String, dynamic>? params);

class RouteConfig {
  final String path;
  final RouteBuilder builder;
  final String? name;

  const RouteConfig({
    required this.path,
    required this.builder,
    this.name,
  });
}