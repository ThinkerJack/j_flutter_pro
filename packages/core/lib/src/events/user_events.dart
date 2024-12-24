import '../../core.dart';

class UserProfileUpdateEvent extends Event {
  final String userId;
  final String? newName;
  final String? newAvatar;

  UserProfileUpdateEvent({
    required this.userId,
    this.newName,
    this.newAvatar,
  });

  @override
  String get type => 'user.profile.update';
}

class UserPageViewEvent extends Event {
  final String pageId;
  final String? userId;
  final DateTime timestamp;

  UserPageViewEvent({
    required this.pageId,
    this.userId,
  }) : timestamp = DateTime.now();

  @override
  String get type => 'user.page.view';
}