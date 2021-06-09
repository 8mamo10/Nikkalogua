import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'dart:math' as math;

import 'package:nikkalogua/CardPage.dart';
import 'package:nikkalogua/Common.dart';
import 'package:nikkalogua/Database.dart';
import 'package:nikkalogua/EditPage.dart';
import 'package:nikkalogua/NikkaModel.dart';
import 'package:nikkalogua/LogModel.dart';
import 'package:nikkalogua/SettingPage.dart';

class CardListPage extends StatefulWidget {
  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  bool _showDeleteButton = false;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).backgroundColor,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              iconSize: 32,
              icon: Icon(
                _showDeleteButton ? Icons.delete : Icons.delete_outline,
                color: Theme.of(context).primaryIconTheme.color,
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
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingPage()));
                },
              ),
            ],
          ),
          body: FutureBuilder<List<Map<String, dynamic>>>(
            future: DBProvider.db.getAllNikkasAndLogs(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.transparent,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == snapshot.data.length) {
                        return _plusCard();
                      } else {
                        return _nikkaCard(context, snapshot.data[index], index);
                      }
                    },
                    itemCount: snapshot.data.length + 1,
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          floatingActionButton: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  heroTag: "DumpDatabase",
                  onPressed: () {
                    this._dumpDatabase();
                  },
                  child: Icon(Icons.search),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  heroTag: "DeleteData",
                  onPressed: () {
                    this._deleteTestData();
                  },
                  child: Icon(Icons.exposure_minus_1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  heroTag: "InsertData",
                  onPressed: () {
                    this._insertTestData();
                  },
                  child: Icon(Icons.exposure_plus_1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _nikkaCard(
      BuildContext context, Map<String, dynamic> nikkaAndLogs, int index) {
    Nikka nikka = nikkaAndLogs["nikka"];
    List<Log> logs = nikkaAndLogs["logs"];

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardPage(
              nikka,
            ),
          ),
        );
        setState(() {});
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
                        return _dailyLogRectangle(nikka, logs, index);
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
                          color: colorTable[nikka.color],
                        ),
                        Text(
                          logs.length.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ]),
                  Text(
                    nikka.name,
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
                    color: Theme.of(context).indicatorColor,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text("確認"),
                            content: Text("日課を削除しますか？"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: () => {
                                  Navigator.pop(context),
                                },
                              ),
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () => {
                                  setState(() {
                                    DBProvider.db.deleteNikka(nikka.id);
                                    DBProvider.db.deleteLogsByNikkaId(nikka.id);
                                  }),
                                  Navigator.pop(context)
                                },
                              ),
                            ],
                          );
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

  Widget _plusCard() {
    return IconButton(
      iconSize: 150,
      icon: Icon(
        Icons.add,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPage(null),
          ),
        );
        setState(
          () {},
        );
      },
    );
  }

  Widget _dailyLogRectangle(Nikka nikka, List<Log> logs, int index) {
    String targetDate = new DateFormat("yyyy-MM-dd")
        .format(this.now.add(new Duration(days: -index)));
    bool isColored = false;
    for (int i = 0; i < logs.length; i++) {
      var log = logs[i];
      if (log.date == targetDate) {
        isColored = true;
        break;
      }
    }
    return Container(
      color: isColored
          ? colorTable[nikka.color]
          : Theme.of(context).highlightColor,
      margin: EdgeInsets.all(3),
    );
  }

  void _addNewNikka() async {
    setState(() {
      var random = math.Random();
      var i = random.nextInt(colorTable.length);
      Nikka nikka = Nikka(
        name: 'nikka' + i.toString(),
        color: i,
      );
      DBProvider.db.newNikka(nikka);
    });
  }

  void _insertTestData() async {
    print("insert");

    await DBProvider.db.newNikka(Nikka(
      name: 'nikka1',
      color: 1,
    ));
    // nikka1
    var nikkas = await DBProvider.db.getAllNikkas();
    if (nikkas.isEmpty) return;
    var nikkaId = nikkas.last.id;
    await DBProvider.db.newLog(Log(
      nikkaId: nikkaId,
      date: "2021-04-01",
    ));
    await DBProvider.db.newLog(Log(
      nikkaId: nikkaId,
      date: "2021-04-02",
    ));
    await DBProvider.db.newLog(Log(
      nikkaId: nikkaId,
      date: "2021-04-03",
    ));
    // nikka2
    await DBProvider.db.newNikka(Nikka(
      name: 'nikka2',
      color: 2,
    ));
    nikkas = await DBProvider.db.getAllNikkas();
    if (nikkas.isEmpty) return;
    nikkaId = nikkas.last.id;
    await DBProvider.db.newLog(Log(
      nikkaId: nikkaId,
      date: "2021-04-03",
    ));
  }

  void _deleteTestData() async {
    print("delete");
    await DBProvider.db.deleteAllLogs();
    await DBProvider.db.deleteAllNikkas();
  }

  void _dumpDatabase() async {
    print("dump");
    print("---nikka---");
    var nikkas = await DBProvider.db.getAllNikkas();
    nikkas.isEmpty
        ? print("No nikka")
        : nikkas.forEach((nikka) {
            print(nikka.toMap());
          });
    print("---log---");
    var logs = await DBProvider.db.getAllLogs();
    logs.isEmpty
        ? print("No log")
        : logs.forEach((log) {
            print(log.toMap());
          });
    print("dump2");
    List<Map<String, dynamic>> nikkasAndLogs =
        await DBProvider.db.getAllNikkasAndLogs();
    nikkasAndLogs.forEach((nikkaAndLogs) {
      Nikka nikka = nikkaAndLogs["nikka"];
      List<Log> logs = nikkaAndLogs["logs"];
      print(nikka.toMap());
      logs.forEach((log) {
        print(log.toMap());
      });
    });
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
    await DBProvider.db.deleteAllNikkas();
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
    DBProvider.db.deleteLogsByNikkaId(1);
    logs = await DBProvider.db.getLogsByNikkaId(1);
    print("logs.length=" + logs.length.toString());

    print("---finish db test---");
  }
}
