import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: MyPage()));
  }
}

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  Color _color = Colors.blue[100];
  double _width = 100;

  void _onTapColor() => setState(() => _color = Colors.blue[900]);
  void _onTapSize() => setState(() => _width = 200);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer'),
      ),
      body: AnimatedContainer(
        color: _color,
        duration: Duration(seconds: 1),
        width: _width,
        height: 100,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(
              Icons.filter_1,
              color: Colors.white,
            ),
            onPressed: _onTapColor,
          ),
          FloatingActionButton(
            child: Icon(
              Icons.filter_2,
              color: Colors.white,
            ),
            onPressed: _onTapSize,
          )
        ],
      ),
    );
  }
}
