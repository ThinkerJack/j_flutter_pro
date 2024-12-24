// packages/user/lib/pages/profile_page.dart
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:router/route.dart';

// packages/user/lib/pages/profile_page.dart
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  final String? userId;

  const ProfilePage({Key? key, this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _userName;

  void _updateProfile() {
    // 模拟更新个人资料
    setState(() {
      _userName = 'Updated User ${DateTime.now().second}';
    });

    // 发送个人资料更新事件
    EventBus().fire(UserProfileUpdateEvent(
      userId: widget.userId ?? '',
      newName: _userName,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: BackButton(
          onPressed: () => AppRouter().pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Profile Page (ID: ${widget.userId})'),
            if (_userName != null)
              Text('Name: $_userName'),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('Update Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                AppRouter().push('/user/settings');
                // 发送页面访问事件
                EventBus().fire(UserPageViewEvent(
                  pageId: 'settings',
                  userId: widget.userId,
                ));
              },
              child: const Text('Go to Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                final newUserId = '${DateTime.now().millisecondsSinceEpoch}';
                AppRouter().push('/user/profile', params: {'id': newUserId});
                // 发送页面访问事件
                EventBus().fire(UserPageViewEvent(
                  pageId: 'profile',
                  userId: newUserId,
                ));
              },
              child: const Text('Go to another profile'),
            ),
          ],
        ),
      ),
    );
  }
}