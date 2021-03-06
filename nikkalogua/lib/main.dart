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
  var _dataList = [
    {'count': 1, 'color': Colors.red},
    {'count': 5, 'color': Colors.blue},
    {'count': 10, 'color': Colors.green},
    {'count': 20, 'color': Colors.yellow},
  ];

  List _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
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
          if (index == _dataList.length) {
            return _cardPlus();
          } else {
            return _cardItem(context, _dataList[index]);
          }
        },
        itemCount: _dataList.length + 1,
      ),
    );
  }

  Widget _cardItem(BuildContext context, Map obj) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NextPage(
                        paramText: 'name' + obj['count'].toString(),
                      )));
        },
        child: Card(
          margin: const EdgeInsets.all(10),
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: obj['color'],
                        margin: EdgeInsets.all(3),
                      );
                    },
                    itemCount: obj['count'],
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
                Text(
                  obj['count'].toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'name' + obj['count'].toString(),
                  style: TextStyle(fontSize: 15),
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
      var num = Random().nextInt(36);
      _dataList.add({
        'name': num.toString(),
        'count': num,
        'color': _colors[Random().nextInt(_colors.length)],
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
        title: Text(
          paramText,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Text(
          this.paramText,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
