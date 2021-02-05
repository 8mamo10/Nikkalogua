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
  bool _tapped1 = false;
  bool _tapped2 = false;
  bool _tapped3 = false;
  bool _tapped4 = false;

  Color _color = Colors.orange[100];
  double _width = 100;
  Alignment _alg = Alignment.topLeft;
  double _padding = 20;

  void _onTapColor() => setState(() => {
        _color = _tapped1 ? Colors.orange[100] : Colors.orange[900],
        _tapped1 = !_tapped1,
      });
  void _onTapSize() => setState(() => {
        _width = _tapped2 ? 100 : 200,
        _tapped2 = !_tapped2,
      });
  void _onTapAlignment() => setState(() => {
        _alg = _tapped3 ? Alignment.topLeft : Alignment.bottomRight,
        _tapped3 = !_tapped3,
      });
  void _onTapPadding() => setState(() => {
        _padding = _tapped4 ? 20 : 50,
        _tapped4 = !_tapped4,
      });

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
