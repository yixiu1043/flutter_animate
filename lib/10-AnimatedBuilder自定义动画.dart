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
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this, // 垂直同步
    )..repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose(); // 释放内存，避免内存泄漏
  }

  @override
  Widget build(BuildContext context) {
    final Animation opacityAnimation = Tween(begin: 0.5, end: 0.8).animate(_animationController);
    final Animation heightAnimation = Tween(begin: 100.0, end: 300.0).animate(_animationController);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              // 方式一
              // opacity: _animationController.value, // 0-1之间
              // 方式二
              // opacity: Tween(begin: 0.5, end: 0.8).evaluate(_animationController), // 0.5-0.8之间
              // 方式三
              opacity: opacityAnimation.value,
              child: Container(
                width: 300,
                // height: 200 + 100 * _animationController.value, // 让高度在200～300之间变化
                // height: Tween(begin: 100.0, end: 300.0).evaluate(_animationController), // 让高度在200～300之间变化
                height: heightAnimation.value,
                color: Colors.blue,
                child: child,
              ),
            );
          },
          child: Center(
            child: Text('Hi', style: TextStyle(fontSize: 72)),
          ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _animationController.stop();
        },
      ),
    );
  }
}

class SlidingBox extends StatelessWidget {
  final Color color;
  final Interval interval;

  const SlidingBox({
    Key key,
    @required AnimationController animationController,
    this.color,
    this.interval,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: Offset(0.1, 0))
          .chain(CurveTween(curve: Curves.bounceOut))
          .chain(CurveTween(curve: interval))
          .animate(_animationController),
      child: Container(width: 300, height: 100, color: color),
    );
  }
}
