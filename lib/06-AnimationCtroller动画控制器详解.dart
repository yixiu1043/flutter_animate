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
      duration: Duration(seconds: 1),
      // lowerBound: 3.0, // 设置下限
      // upperBound: 5.0, // 设置上限
      vsync: this, // 垂直同步
    );

    _animationController.addListener(() {
      // print('${_animationController.value}'); // 0-1之间的数字
      // 设置 lowerBound 和 upperBound 后
      // print('${_animationController.value}'); // 3-5之间的数字
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
        // demo 1
        // child: RotationTransition(
        //   turns: _animationController,
        //   child: Container(
        //     width: 300,
        //     height: 300,
        //     color: Colors.blue,
        //   ),
        // )
        // demo 2
        // child: FadeTransition(
        //   opacity: _animationController,
        //   child: Container(
        //     width: 300,
        //     height: 300,
        //     color: Colors.blue,
        //   ),
        // )
        // demo 2
        child: ScaleTransition(
        scale: _animationController,
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
          // _animationController.forward();
          _animationController.repeat(reverse: true); // 反转
        },
      ),
    );
  }
}
