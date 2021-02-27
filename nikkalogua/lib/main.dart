import 'dart:math';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nikkalogua/ClientsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String _title = 'Nikkalogua';

  var _nameList = <String>['str1', 'str2', 'str3', 'str4'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(body: ClientsPage()),
/*
        appBar: AppBar(
          leading: Icon(Icons.copy),
          title: const Text(_title),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == _nameList.length) {
              return _cardPlus();
            } else {
              return _cardItem(context, _nameList[index]);
            }
          },
          itemCount: _nameList.length + 1,
        ),
      ),
      */
    );
  }

  Widget _cardItem(BuildContext context, String name) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NextPage(
                        paramText: name,
                      )));
        },
        child: Card(
          margin: const EdgeInsets.all(10.0),
          child: Container(
            width: 200,
            height: 200,
            child: Text(
              name,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ));
  }

  Widget _cardPlus() {
    return IconButton(
      iconSize: 150,
      icon: Icon(Icons.add),
      onPressed: _handlePlus,
    );
  }

  void _handlePlus() {
    setState(() {
      _nameList.add(Random().nextInt(100).toString());
    });
  }
}

class NextPage extends StatelessWidget {
  final String paramText;

  NextPage({Key key, @required this.paramText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next page'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.red,
        child: Text(this.paramText),
      ),
    );
  }
}
