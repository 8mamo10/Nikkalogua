import 'dart:math';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:nikkalogua/ClientsPage.dart';
import 'package:nikkalogua/CardPage.dart';
import 'package:nikkalogua/SettingPage.dart';

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
  bool _showDeleteButton = false;

  // To be stored on DB
  List _dataList = [
    {
      'name': 'work1',
      'count': 1,
      'color': Colors.red,
    },
    {
      'name': 'work2',
      'count': 5,
      'color': Colors.blue,
    },
    {
      'name': 'work3',
      'count': 10,
      'color': Colors.green,
    },
    {
      'name': 'work4',
      'count': 20,
      'color': Colors.yellow,
    },
    {
      'name': 'work5',
      'count': 35,
      'color': Colors.purple,
    },
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
        leading: IconButton(
          iconSize: 32,
          icon: Icon(
            _showDeleteButton ? Icons.delete : Icons.delete_outline,
          ),
          onPressed: () {
            setState(() {
              _showDeleteButton = !_showDeleteButton;
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 32,
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPage()));
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == _dataList.length) {
              return _cardPlus();
            } else {
              return _cardItem(context, _dataList[index], index);
            }
          },
          itemCount: _dataList.length + 1,
        ),
      ),
    );
  }

  Widget _cardItem(BuildContext context, Map obj, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CardPage(
                      params: obj,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Container(
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
                          color: index < obj['count']
                              ? obj['color']
                              : Colors.grey[300],
                          margin: EdgeInsets.all(3),
                        );
                      },
                      itemCount: 35,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.local_fire_department,
                          color: obj['color'],
                        ),
                        Text(
                          obj['count'].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ]),
                  Text(
                    obj['name'],
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _showDeleteButton,
              child: Container(
                margin: EdgeInsets.all(5),
                alignment: Alignment.topRight,
                child: IconButton(
                  iconSize: 32,
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _dataList.removeAt(index);
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
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
        'name': 'work' + _dataList.length.toString(),
        'count': num,
        'color': _colors[Random().nextInt(_colors.length)],
      });
    });
  }
}
