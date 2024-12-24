// packages/home/lib/pages/home_page.dart
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:router/route.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _lastViewedProfile;
  String? _lastUpdatedUser;

  @override
  void initState() {
    super.initState();
    // 订阅个人资料更新事件
    EventBus().on<UserProfileUpdateEvent>(this, (event) {
      setState(() {
        _lastUpdatedUser = event.userId;
      });
    });

    // 订阅页面访问事件
    EventBus().on<UserPageViewEvent>(this, (event) {
      if (event.pageId == 'profile') {
        setState(() {
          _lastViewedProfile = event.userId;
        });
      }
    });
  }

  @override
  void dispose() {
    EventBus().off(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_lastViewedProfile != null)
              Text('Last viewed profile: $_lastViewedProfile'),
            if (_lastUpdatedUser != null)
              Text('Last updated user: $_lastUpdatedUser'),
            ElevatedButton(
              onPressed: () {
                AppRouter().push('/user/profile', params: {'id': '123'});
                // 发送页面访问事件
                EventBus().fire(UserPageViewEvent(
                  pageId: 'profile',
                  userId: '123',
                ));
              },
              child: const Text('Go to Profile'),
            ),
            ElevatedButton(
              onPressed: () => AppRouter().push('/user/settings'),
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}