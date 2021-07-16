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

    _animationController.addListener(() {
      // print('${_animationController.value}'); // 0-1之间的数字
    });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlidingBox(animationController: _animationController, color: Colors.blue[100], interval: Interval(0.0, 0.2),),
              SlidingBox(animationController: _animationController, color: Colors.blue[300], interval: Interval(0.2, 0.4),),
              SlidingBox(animationController: _animationController, color: Colors.blue[500], interval: Interval(0.4, 0.6),),
              SlidingBox(animationController: _animationController, color: Colors.blue[700], interval: Interval(0.6, 0.8),),
              SlidingBox(animationController: _animationController, color: Colors.blue[900], interval: Interval(0.8, 1.0),),
          ]
        )),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () {
    _animationController.stop();
    },
    )
    ,
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
  }) : _animationController = animationController, super(key: key);

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
