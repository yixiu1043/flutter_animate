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
        // demo 01
        // child: ScaleTransition(
        //   scale: _animationController.drive(Tween(begin: 0.5, end: 2.0)),
        //   child: Container(
        //     width: 300,
        //     height: 300,
        //     color: Colors.blue,
        //   ),
        // )
        // demo 02
          child: SlideTransition(
            // position: _animationController.drive(Tween(begin: Offset(0, 0), end: Offset(0.1, 0))),
            position: Tween(begin: Offset(0, -0.5), end: Offset(0, 0.8))
                .chain(CurveTween(curve: Curves.elasticInOut))
                .chain(CurveTween(curve: Interval(0.8, 1.0))) // Interval 前80%也就是4秒钟定住不动，后1秒完成动画
                .animate(_animationController),
            child: Container(
              width: 300,
              height: 300,
              color: Colors.blue,
            ),
          )
      ),
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
