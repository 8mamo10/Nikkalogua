import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:nikkalogua/Common.dart';
import 'package:nikkalogua/Database.dart';
import 'package:nikkalogua/EditPage.dart';
import 'package:nikkalogua/LogModel.dart';
import 'package:nikkalogua/NikkaModel.dart';

class CardPage extends StatefulWidget {
  final Nikka _nikka;
  final now = new DateFormat("yyyy-MM-dd").format(DateTime.now());
  CardPage(this._nikka);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  Nikka _nikka;

  @override
  void initState() {
    this._nikka = widget._nikka;
    super.initState();
  }

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
            title: FutureBuilder<Nikka>(
              future: DBProvider.db.getNikka(this._nikka.id),
              builder: (BuildContext context, AsyncSnapshot<Nikka> snapshot) {
                if (snapshot.hasData) {
                  this._nikka = snapshot.data;
                  return Text(
                    snapshot.data.name,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            actions: <Widget>[
              IconButton(
                iconSize: 32,
                icon: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(this._nikka),
                    ),
                  );
                  setState(() {});
                },
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: FutureBuilder<List<Log>>(
            future: DBProvider.db.getLogsByNikkaId(this._nikka.id),
            builder: (BuildContext context, AsyncSnapshot<List<Log>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  alignment: Alignment.topCenter,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        for (int i = 0; i < snapshot.data.length; i++)
                          _dailyLine(snapshot.data, i)
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          floatingActionButton: FutureBuilder<List<Log>>(
            future: DBProvider.db.getLogsByNikkaId(this._nikka.id),
            builder: (BuildContext context, AsyncSnapshot<List<Log>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if ((snapshot.data.length == 0) ||
                        (snapshot.data.first?.date != widget.now))
                      FloatingActionButton.extended(
                        heroTag: "AddLog",
                        tooltip: "AddLog",
                        icon: Icon(Icons.add),
                        label: Text("Add"),
                        onPressed: () {
                          setState(
                            () {
                              DBProvider.db.newLog(
                                Log(
                                  nikkaId: this._nikka.id,
                                  date: widget.now,
                                ),
                              );
                            },
                          );
                        },
                        backgroundColor: colorTable[this._nikka.color],
                      )
                    else
                      FloatingActionButton.extended(
                        heroTag: "DeleteLog",
                        tooltip: "DeleteLog",
                        icon: Icon(Icons.remove),
                        label: Text("Delete"),
                        onPressed: () {
                          setState(() {
                            DBProvider.db.deleteLogByNikaIdAndDate(
                              this._nikka.id,
                              widget.now,
                            );
                          });
                        },
                        backgroundColor: colorTable[this._nikka.color],
                      )
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _dailyLine(List<Log> logs, int count) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 100.0),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: FutureBuilder<Nikka>(
                future: DBProvider.db.getNikka(this._nikka.id),
                builder: (BuildContext context, AsyncSnapshot<Nikka> snapshot) {
                  if (snapshot.hasData) {
                    this._nikka = snapshot.data;
                    return Container(
                      margin: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: colorTable[this._nikka.color],
                      ),
                      child: Text(
                        (logs.length - count).toString(),
                        style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontSize: 25,
                        ),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                DateFormat('yyyy/MM/dd')
                    .format(DateTime.parse(logs[count].date)),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
