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
  double _height = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: Duration(seconds: 1),
          width: 300,
          height: _height,
          color: Colors.orange,
          // child: CircularProgressIndicator(),
          child: AnimatedSwitcher(
              duration: Duration(seconds: 2),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
              // child: Image.network('https://img9.doubanio.com/view/photo/l/public/p2509215427.webp'),
              // child: null, // child给null会有一个淡出消息的效果
              // child: Text(
              //   'Hello',
              //   key: ValueKey('Hello'),
              //   style: TextStyle(fontSize: 100),
              // )
              child: Text(
                'Hello',
                key: UniqueKey(), // 独一无二的key
                style: TextStyle(fontSize: 100),
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _height += 100;
          });
        },
      ),
    );
  }
}
