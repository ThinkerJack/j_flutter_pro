import 'dart:async';

class EventBus {
  // 单例实现
  static final EventBus _instance = EventBus._internal();
  factory EventBus() => _instance;
  EventBus._internal();

  // 事件流控制器
  final _controller = StreamController<Event>.broadcast();

  // 存储所有订阅
  final _subscriptions = <Object, List<StreamSubscription>>{};

  // 发送事件
  void fire(Event event) {
    _controller.add(event);
  }

  // 订阅事件
  void on<T extends Event>(
      Object subscriber,
      void Function(T event) onData,
      ) {
    if (!_subscriptions.containsKey(subscriber)) {
      _subscriptions[subscriber] = [];
    }

    final subscription = _controller.stream
        .where((event) => event is T)
        .cast<T>()
        .listen(onData);

    _subscriptions[subscriber]!.add(subscription);
  }

  // 取消订阅
  void off(Object subscriber) {
    final subs = _subscriptions[subscriber];
    if (subs != null) {
      for (var subscription in subs) {
        subscription.cancel();
      }
      _subscriptions.remove(subscriber);
    }
  }

  // 销毁
  void dispose() {
    for (var subs in _subscriptions.values) {
      for (var subscription in subs) {
        subscription.cancel();
      }
    }
    _subscriptions.clear();
    _controller.close();
  }
}

// 基础事件类
abstract class Event {
  String get type;
}