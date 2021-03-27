import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:nikkalogua/CardPage.dart';
import 'package:nikkalogua/SettingPage.dart';

class CardListPage extends StatefulWidget {
  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  bool _showDeleteButton = false;

  // To be stored on DB
  List _dataList = [
    {
      'name': 'work0',
      'color': Colors.red,
      'days': [
        '2021-03-30',
      ],
    },
    {
      'name': 'work1',
      'color': Colors.blue,
      'days': [
        '2021-03-30',
        '2021-03-29',
        '2021-03-28',
        '2021-03-27',
        '2021-03-26',
      ],
    },
    {
      'name': 'work2',
      'color': Colors.green,
      'days': [
        '2021-03-30',
        '2021-03-29',
        '2021-03-28',
        '2021-03-27',
        '2021-03-26',
        '2021-03-25',
        '2021-03-24',
        '2021-03-23',
        '2021-03-22',
        '2021-03-21',
      ],
    },
    {
      'name': 'work3',
      'color': Colors.yellow,
      'days': [
        '2021-03-30',
        '2021-03-29',
        '2021-03-28',
        '2021-03-27',
        '2021-03-26',
        '2021-03-25',
        '2021-03-24',
        '2021-03-23',
        '2021-03-22',
        '2021-03-21',
        '2021-03-20',
        '2021-03-19',
        '2021-03-18',
        '2021-03-17',
        '2021-03-16',
        '2021-03-15',
        '2021-03-14',
        '2021-03-13',
        '2021-03-12',
        '2021-03-11',
      ]
    },
    {
      'name': 'work4',
      'color': Colors.purple,
      'days': [
        '2021-03-30',
        '2021-03-29',
        '2021-03-28',
        '2021-03-27',
        '2021-03-26',
        '2021-03-25',
        '2021-03-24',
        '2021-03-23',
        '2021-03-22',
        '2021-03-21',
        '2021-03-20',
        '2021-03-19',
        '2021-03-18',
        '2021-03-17',
        '2021-03-16',
        '2021-03-15',
        '2021-03-14',
        '2021-03-13',
        '2021-03-12',
        '2021-03-11',
        '2021-03-10',
        '2021-03-09',
        '2021-03-08',
        '2021-03-07',
        '2021-03-06',
        '2021-03-05',
        '2021-03-04',
        '2021-03-03',
        '2021-03-02',
        '2021-03-01',
        '2021-02-28',
        '2021-02-27',
        '2021-02-26',
        '2021-02-25',
        '2021-02-24',
      ]
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
                          color: index < obj['days'].length
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
                          obj['days'].length.toString(),
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
        'color': _colors[Random().nextInt(_colors.length)],
        'days': [],
      });
    });
  }
}
