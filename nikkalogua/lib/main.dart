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
  Alignment _alg = Alignment.topLeft;

  void _onTapColor() => setState(() => _color = Colors.blue[900]);
  void _onTapSize() => setState(() => _width = 200);
  void _onTapAlignment() => setState(() => _alg = Alignment.bottomRight);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer'),
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        alignment: _alg,
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          width: _width,
          height: 100,
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
          )
        ],
      ),
    );
  }
}
