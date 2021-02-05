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
  Color _color = Colors.orange[100];
  double _width = 100;
  Alignment _alg = Alignment.topLeft;
  double _padding = 20;

  void _onTapColor() => setState(() => _color = Colors.orange[900]);
  void _onTapSize() => setState(() => _width = 200);
  void _onTapAlignment() => setState(() => _alg = Alignment.bottomRight);
  void _onTapPadding() => setState(() => _padding = 50);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer'),
      ),
      body: AnimatedContainer(
        width: 400,
        height: 400,
        duration: Duration(seconds: 1),
        color: Colors.blueAccent,
        alignment: _alg,
        padding: EdgeInsets.all(_padding),
        child: AnimatedContainer(
          width: _width,
          height: 100,
          duration: Duration(seconds: 1),
          color: _color,
        ),
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
          ),
          FloatingActionButton(
            child: Icon(
              Icons.filter_3,
              color: Colors.white,
            ),
            onPressed: _onTapAlignment,
          ),
          FloatingActionButton(
            child: Icon(
              Icons.filter_4,
              color: Colors.white,
            ),
            onPressed: _onTapPadding,
          ),
        ],
      ),
    );
  }
}
