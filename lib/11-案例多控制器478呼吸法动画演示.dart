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

// 方式一，使用交错动画
// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   AnimationController _controller;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 20),
//       vsync: this, // 垂直同步
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _controller.dispose(); // 释放内存，避免内存泄漏
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // 478 呼吸法
//     // 方式一，使用交错动画
//     Animation animation1 = Tween(begin: 0.0, end: 1.0)
//     .chain(CurveTween(curve: Interval(0.0, 0.2))).animate(_controller);
//     Animation animation2 = Tween(begin: 1.0, end: 0.0)
//     .chain(CurveTween(curve: Interval(0.4, 0.95))).animate(_controller);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (BuildContext context, Widget child) {
//             return Container(
//               width: 300,
//               height: 300,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [
//                     Colors.blue[600],
//                     Colors.blue[100]
//                   ],
//                   // stop 用来控制过渡的界限
//                   stops: _controller.value <= 0.2 ?
//                   [animation1.value, animation1.value + 0.1]:
//                   [animation2.value, animation2.value + 0.1]
//                 )
//               ),
//             );
//           },
//         )
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           _controller.stop();
//         },
//       ),
//     );
//   }
// }

// 方式二
class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  AnimationController _expansionController;
  AnimationController _opacityController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _expansionController = AnimationController(vsync: this);
    _opacityController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _expansionController.dispose(); // 释放内存，避免内存泄漏
    _opacityController.dispose(); // 释放内存，避免内存泄漏
  }

  @override
  Widget build(BuildContext context) {
    // 478 呼吸法
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FadeTransition(
            opacity:  Tween(begin: 1.0, end: 0.5).animate(_opacityController),
            child: AnimatedBuilder(
              animation: _expansionController,
              builder: (BuildContext context, Widget child) {
                return Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.blue[600],
                        Colors.blue[100]
                      ],
                      // stop 用来控制过渡的界限
                      stops: [_expansionController.value, _expansionController.value + 0.1]
                    )
                  ),
                );
              },
            ),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          _expansionController.duration = Duration(seconds: 4);
          _expansionController.forward();

          await Future.delayed(Duration(seconds: 4));

          _opacityController.duration = Duration(milliseconds: 1750); // 7000 / 4
          _opacityController.repeat(reverse: true);

          await Future.delayed(Duration(seconds: 7));
          _opacityController.reset();

          _expansionController.duration = Duration(seconds: 8);
          _expansionController.reverse();
        },
      ),
    );
  }
}
