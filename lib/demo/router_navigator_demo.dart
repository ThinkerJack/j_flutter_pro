import 'package:flutter/material.dart';

class RouterNavigatorDemo extends StatefulWidget {
  const RouterNavigatorDemo({super.key});

  @override
  State<RouterNavigatorDemo> createState() => _RouterNavigatorDemoState();
}

class _RouterNavigatorDemoState extends State<RouterNavigatorDemo> {
  bool flag = false;

  void toggleFlag() {
    setState(() {
      flag = !flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Navigator(
          pages: [
            MaterialPage(
              child: Page1(
                flag: flag,
                onToggle: toggleFlag,
              ),
            ),
            if (flag)
              MaterialPage(
                child: Page2(),
              ),
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }
            setState(() {
              flag = false;
            });
            return true;
          },
        ));
  }
}

class Page1 extends StatelessWidget {
  final bool flag;
  final VoidCallback onToggle;

  const Page1({
    super.key,
    required this.flag,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('当前 flag 状态: ${flag ? "true" : "false"}'),
            const SizedBox(height: 20),
            TextButton(
              onPressed: onToggle,
              child: const Text("切换页面"),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool showPage3 = false;

  void togglePage3() {
    setState(() {
      showPage3 = !showPage3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: Navigator(
        pages: [
          MaterialPage(
            child: Page2Content(
              showPage3: showPage3,
              onTogglePage3: togglePage3,
            ),
          ),
          if (showPage3)
            MaterialPage(
              child: Page3(),
            ),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          setState(() {
            showPage3 = false;
          });
          return true;
        },
      ),
    );
  }
}

class Page2Content extends StatelessWidget {
  final bool showPage3;
  final VoidCallback onTogglePage3;

  const Page2Content({
    super.key,
    required this.showPage3,
    required this.onTogglePage3,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('这是 Page 2'),
          const SizedBox(height: 20),
          Text('Page3 状态: ${showPage3 ? "显示" : "隐藏"}'),
          const SizedBox(height: 20),
          TextButton(
            onPressed: onTogglePage3,
            child: const Text('打开 Page 3'),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('返回 Page 1'),
          ),
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('这是 Page 3'),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('返回 Page 2'),
            ),
          ],
        ),
      ),
    );
  }
}
