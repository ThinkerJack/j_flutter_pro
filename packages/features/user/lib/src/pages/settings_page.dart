// packages/user/lib/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:router/route.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: BackButton(
          onPressed: () => AppRouter().pop(),
        ),
      ),
      body: const Center(
        child: Text('User Settings Page'),
      ),
    );
  }
}