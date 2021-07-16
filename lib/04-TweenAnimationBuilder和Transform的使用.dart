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

class _MyHomePageState extends State<MyHomePage> {
  double _top = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // demo 1
        // child: TweenAnimationBuilder(
        //   duration: Duration(seconds: 1),
        //   tween: Tween(begin: 0.0, end: 1),
        //   builder: (BuildContext context, num value, Widget child) {
        //     return Opacity(
        //       opacity: value,
        //       child: Container(
        //         width: 300,
        //         height: 300,
        //         color: Colors.blue,
        //       ),
        //     );
        //   },
        // ),
        // demo 2
        // child: TweenAnimationBuilder(
        //   duration: Duration(seconds: 1),
        //   // tween: Tween(begin: 50, end: 100), // error
        //   // tween: Tween<double>(begin: 50, end: 100), // correct
        //   // tween: Tween(begin: 50.0, end: 100.0),
        //   tween: Tween(end: 100.0), // 不传begin 那么默认会将end的值复制一份给begin
        //   builder: (BuildContext context, num value, Widget child) {
        //     return Container(
        //       width: 300,
        //       height: 300,
        //       color: Colors.blue,
        //       child: Center(child: Text('Hi', style: TextStyle(fontSize: value),)),
        //     );
        //   },
        // ),
        // demo 3
        child: TweenAnimationBuilder(
          duration: Duration(seconds: 1),
          tween: Tween(begin: 0, end: 1.5),
          // tween: Tween(begin: 0.0, end: 3.14), // Pi: 3.14 半圆
          // tween: Tween(begin: Offset(0.0, 0.0), end: Offset(20.0, 20.0)),
          builder: (BuildContext context, num value, Widget child) {
            return Container(
              width: 300,
              height: 300,
              color: Colors.blue,
              // 1. Transform.scale
              child: Transform.scale(
                scale: value,
                child: Center(child: Text('Hi', style: TextStyle(fontSize: 75),))
              ),
              // 2. Transform.rotate
              // child: Transform.rotate(
              //     angle: value,
              //     child: Center(child: Text('Hi', style: TextStyle(fontSize: 75),))
              // ),
              // 3. Transform.translate
              // child: Transform.translate(
              //     offset: value,
              //     child: Center(child: Text('Hi', style: TextStyle(fontSize: 75),))
              // ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _top += 50;
          });
        },
      ),
    );
  }
}
