import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:nikkalogua/CardPage.dart';
import 'package:nikkalogua/Database.dart';
import 'package:nikkalogua/NikkaModel.dart';
import 'package:nikkalogua/LogModel.dart';
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
      'id': 0,
      'name': 'work0',
      'color': Colors.red,
      'days': [
        '2021-03-30',
      ],
    },
    {
      'id': 1,
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
      'id': 2,
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
      'id': 3,
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
      'id': 4,
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
        floatingActionButton: Column(
          verticalDirection: VerticalDirection.up,
          children: [
            FloatingActionButton(
              onPressed: () {
                this._deleteTestData();
              },
              child: Icon(Icons.exposure_minus_1),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  this._insertTestData();
                },
                child: Icon(Icons.exposure_plus_1),
              ),
            ),
          ],
        ));
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

  void _handlePlus() async {
    setState(() {
      _dataList.add({
        'name': 'work' + _dataList.length.toString(),
        'color': _colors[Random().nextInt(_colors.length)],
        'days': [],
      });
    });
  }

  void _insertTestData() async {
    print("insert");
  }

  void _deleteTestData() async {
    print("delete");
    await DBProvider.db.deleteLogByNikkaId(1);
    await DBProvider.db.deleteAllNikka();
  }

  void _dbTest() async {
    // DB access test
    //// nikka
    ////// insert
    print("---begin db test---");
    print("insert a nikka");
    await DBProvider.db.newNikka(Nikka(
      name: 'aaaaa',
      color: 1,
    ));
    ////// select
    print("select the nikkas");
    var nikkas = await DBProvider.db.getAllNikkas();
    print(nikkas.toString());
    for (int i = 0; i < nikkas.length; i++) {
      print(nikkas[i].toMap());
    }
    ///// update
    print("update the nikka");
    var changedNikka = nikkas.last;
    changedNikka.name = 'bbbbb';
    changedNikka.color = 2;
    ////// update
    DBProvider.db.updateNikka(changedNikka);
    print(nikkas.last.toMap());
    ////// delete
    print("delete the nikka");
    DBProvider.db.deleteNikka(changedNikka.id);
    nikkas = await DBProvider.db.getAllNikkas();
    nikkas.forEach((nikka) {
      print(nikka.toMap());
    });
    ////// delete all
    print("delete all nikka");
    await DBProvider.db.deleteAllNikka();
    nikkas = await DBProvider.db.getAllNikkas();
    print("nikkas.length=" + nikkas.length.toString());
    //// log
    ///// insert
    print("insert logs");
    await DBProvider.db.newLog(Log(
      nikkaId: 1,
      date: "2021-04-03",
    ));
    await DBProvider.db.newLog(Log(
      nikkaId: 1,
      date: "2021-04-02",
    ));
    await DBProvider.db.newLog(Log(
      nikkaId: 1,
      date: "2021-04-04",
    ));
    ///// select
    //var log = await DBProvider.db.getLog(1);
    //print(log.toMap());
    print("select the logs");
    var logs = await DBProvider.db.getLogsByNikkaId(1);
    logs.forEach((log) {
      print(log.toMap());
    });
    ////// delete
    print("delete a log");
    DBProvider.db.deleteLog(logs.last.id);
    logs = await DBProvider.db.getLogsByNikkaId(1);
    logs.forEach((log) {
      print(log.toMap());
    });
    ////// delete by nikka_id
    print("delete all log");
    DBProvider.db.deleteLogByNikkaId(1);
    logs = await DBProvider.db.getLogsByNikkaId(1);
    print("logs.length=" + logs.length.toString());

    print("---finish db test---");
  }
}
