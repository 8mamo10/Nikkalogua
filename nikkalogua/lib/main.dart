import 'dart:math';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:nikkalogua/ClientsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Nikkalogua';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: CardListPage(),
    );
  }
}

class CardListPage extends StatefulWidget {
  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  var _nameList = [
    {'name': 'str1', 'count': 10},
    {'name': 'str2', 'count': 20},
    {'name': 'str3', 'count': 30},
    {'name': 'str4', 'count': 40},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.copy),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NextPage(
                            paramText: 'Setting',
                          )));
            },
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
            return _cardItem(
                context, _nameList[index]['name'], _nameList[index]);
          }
        },
        itemCount: _nameList.length + 1,
      ),
    );
  }

  Widget _cardItem(BuildContext context, String name, Map obj) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NextPage(
                        paramText: obj['name'],
                      )));
        },
        child: Card(
          margin: const EdgeInsets.all(10.0),
          child: Container(
            width: 200,
            height: 200,
            child: Column(
              children: [
                Text(
                  obj['count'].toString(),
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  obj['name'],
                  style: TextStyle(fontSize: 30),
                ),
              ],
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
      var num = Random().nextInt(100);
      _nameList.add({
        'name': num.toString(),
        'count': num,
      });
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
        title: Text(paramText),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Text(this.paramText),
      ),
    );
  }
}
