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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          // demo 1
          child: Container(
        width: 300,
        height: 120,
        color: Colors.blue,
        child: AnimatedCounter(value: _counter, duration: Duration(seconds: 1),),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _incrementCounter,
      ),
    );
  }
}

class AnimatedCounter extends StatelessWidget {
  final int value;
  final Duration duration;
  const AnimatedCounter({Key key, @required this.value, @required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      tween: Tween(end: value.toDouble()),
      builder: (BuildContext context, Object value, Widget child) {
        final whole = num.parse(value.toString()) ~/ 1; // 整数部分
        final decimal = num.parse(value.toString()) - whole; // 小数部分
        print('$whole + $decimal');
        return Stack(
          children: [
            Positioned(
                top: -100 * decimal, // 0 -> -100
                child: Opacity(
                    opacity: 1 - decimal,
                    child: Text(
                      '$whole',
                      style: TextStyle(fontSize: 100),
                    ))),
            Positioned(
                top: 100 - decimal * 100, // 100 -> 0
                child: Opacity(
                    opacity: decimal,
                    child: Text(
                      '${whole + 1}',
                      style: TextStyle(fontSize: 100),
                    )))
          ],
        );
      },
    );
  }
}
