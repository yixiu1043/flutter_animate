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
      // body: Center(
      // child: Opacity(
      //   opacity: 1,
      //   child: Container(
      //     width: 300,
      //     height: 300,
      //     color: Colors.blue,
      //   ),
      // ),
      // child: AnimatedOpacity(
      //   duration: Duration(seconds: 1),
      //   curve: Curves.bounceInOut,
      //   // opacity: 0.5,
      //   opacity: 0,
      //   child: Container(
      //     width: 300,
      //     height: 300,
      //     color: Colors.blue,
      //   ),
      // ),
      // ),
      // body: Padding(
      //   padding: EdgeInsets.all(50),
      //   child: Container(
      //     width: 300,
      //     height: 300,
      //     color: Colors.blue,
      //   ),
      // ),
      body: AnimatedPadding(
        duration: Duration(seconds: 2),
        curve: Curves.bounceOut,
        padding: EdgeInsets.only(top: _top),
        child: Container(
          width: 300,
          height: 300,
          color: Colors.blue,
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
