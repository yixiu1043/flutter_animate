import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
      home: MyHomePage(title: 'CustomPainter操作底层的绘制'),
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  List<Snowflake> _snowflakes = List.generate(1000, (index) => Snowflake());

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          /// 以下两种方法等效
          // constraints: BoxConstraints.expand(),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlue, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // stops: [0.0, 0.5, 1.0], // 默认值，均匀分布
              stops: [0.0, 0.7, 0.95],
            ),
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              _snowflakes.forEach((snow) => snow.fall());
              return CustomPaint(
                painter: MyPainter(_snowflakes),
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

/// 画出雪人
class MyPainter extends CustomPainter {
  List<Snowflake> _snowflakes;

  MyPainter(this._snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    /// size 画布的大小
    // print(size); // Size(375.0, 591.0)

    final whitePaint = Paint()..color = Colors.white;

    /// 以下两种方法等效
    // canvas.drawCircle(Offset(size.width /2, size.height/2), 20, Paint());
    canvas.drawCircle(size.center(Offset(0, 100)), 60, whitePaint);

    /// 画椭圆
    canvas.drawOval(
      Rect.fromCenter(
        center: size.center(Offset(0, 280)),
        width: 200,
        height: 250,
      ),
      whitePaint,
    );

    _snowflakes.forEach((snowflake) {
      canvas.drawCircle(Offset(snowflake.x, snowflake.y), snowflake.radius, whitePaint);
    });
  }

  /// 是否重画
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// 画出雪花
class Snowflake {
  double x = Random().nextDouble() * 375;
  double y = Random().nextDouble() * 800;
  double velocity = Random().nextDouble() * 4 + 2; // 速度
  double radius = Random().nextDouble() * 2 + 2;

  fall() {
    y += velocity;
    if (y > 800) {
      y = 0;
      x = Random().nextDouble() * 375;
      y = Random().nextDouble() * 800;
      velocity = Random().nextDouble() * 4 + 2; // 速度
      radius = Random().nextDouble() * 2 + 2;
    }
  }
}
