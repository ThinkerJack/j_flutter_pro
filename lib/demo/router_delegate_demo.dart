import 'package:flutter/material.dart';

// 1. 定义路由路径数据结构
class AppRoutePath {
  final String location;
  final bool isUnknown;

  AppRoutePath.home()
      : location = '/',
        isUnknown = false;

  AppRoutePath.detail(String id)
      : location = '/detail/$id',
        isUnknown = false;

  AppRoutePath.unknown()
      : location = '/404',
        isUnknown = true;
}

// 2. 路由代理
class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  bool _showDetail = false;
  String? _selectedId;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  // 当前路由状态
  @override
  AppRoutePath get currentConfiguration {
    if (_showDetail) {
      return AppRoutePath.detail(_selectedId ?? '');
    }
    return AppRoutePath.home();
  }

  // 构建导航器
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        // 首页永远在栈底
        MaterialPage(
          key: ValueKey('HomePage'),
          child: HomePage(
            onTapped: _handleItemTapped,
          ),
        ),
        // 详情页根据条件显示
        if (_showDetail)
          MaterialPage(
            key: ValueKey('DetailPage'),
            child: DetailPage(
              id: _selectedId,
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // 处理返回逻辑
        _showDetail = false;
        _selectedId = null;
        notifyListeners();

        return true;
      },
    );
  }

  // 处理点击事件
  void _handleItemTapped(String id) {
    _selectedId = id;
    _showDetail = true;
    notifyListeners();
  }

  // 路由信息设置
  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    if (configuration.isUnknown) {
      _selectedId = null;
      _showDetail = false;
      return;
    }

    if (configuration.location.startsWith('/detail/')) {
      _selectedId = configuration.location.replaceFirst('/detail/', '');
      _showDetail = true;
      return;
    }

    _selectedId = null;
    _showDetail = false;
  }
}

// 3. 路由信息解析器
class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  // 解析路由信息
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    // 处理详情页路由
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'detail') {
      return AppRoutePath.detail(uri.pathSegments[1]);
    }

    // 处理首页路由
    if (uri.path == '/') {
      return AppRoutePath.home();
    }

    // 处理未知路由
    return AppRoutePath.unknown();
  }

  // 还原路由信息
  @override
  RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: '/404');
    }
    return RouteInformation(location: configuration.location);
  }
}

// 4. 示例页面
class HomePage extends StatelessWidget {
  final ValueChanged<String> onTapped;

  const HomePage({Key? key, required this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
            onTap: () => onTapped(index.toString()),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String? id;

  const DetailPage({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Center(
        child: Text('Detail page for item $id'),
      ),
    );
  }
}

class RouterDelegateDemo extends StatelessWidget {
  const RouterDelegateDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AppRouterDelegate(),
      routeInformationParser: AppRouteInformationParser(),
    );
  }
}