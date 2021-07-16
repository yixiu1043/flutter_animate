import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// with SingleTickerProviderStateMixin 获取垂直同步数据
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  bool _loading = false;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this, // 垂直同步
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose(); // 释放内存，避免内存泄漏
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RotationTransition(
          turns: _animationController,
          child: Icon(
            Icons.refresh,
            size: 100,
          ),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // _animationController.forward(); // 动画运行一次
          if (_loading) {
            // _animationController.reset(); // 动画重置到开始到位置
            _animationController.stop(); // 动画原地停止
          } else {
            _animationController.repeat(); // 动画无限循环
          }
          _loading = !_loading;
        },
      ),
    );
  }
}
