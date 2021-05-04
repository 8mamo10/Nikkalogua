import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:nikkalogua/Common.dart';
import 'package:nikkalogua/Database.dart';
import 'package:nikkalogua/LogModel.dart';
import 'package:nikkalogua/NikkaModel.dart';

class CardPage extends StatefulWidget {
  final Nikka nikka;
  final now = new DateFormat("yyyy-MM-dd").format(DateTime.now());
  CardPage(this.nikka);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          widget.nikka.name,
        ),
      ),
      body: FutureBuilder<List<Log>>(
        future: DBProvider.db.getLogsByNikkaId(widget.nikka.id),
        builder: (BuildContext context, AsyncSnapshot<List<Log>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              alignment: Alignment.topCenter,
              color: Colors.grey[200],
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
        future: DBProvider.db.getLogsByNikkaId(widget.nikka.id),
        builder: (BuildContext context, AsyncSnapshot<List<Log>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if ((snapshot.data.length == 0) ||
                    (snapshot.data.first?.date != widget.now))
                  FloatingActionButton(
                    heroTag: "AddLog",
                    onPressed: () {
                      setState(() {
                        DBProvider.db.newLog(Log(
                          nikkaId: widget.nikka.id,
                          date: widget.now,
                        ));
                      });
                    },
                    backgroundColor: colorTable[widget.nikka.color],
                    child: Icon(Icons.exposure_plus_1),
                  )
                else
                  FloatingActionButton(
                    heroTag: "DeleteLog",
                    onPressed: () {
                      setState(() {
                        DBProvider.db.deleteLogByNikaIdAndDate(
                          widget.nikka.id,
                          widget.now,
                        );
                      });
                    },
                    backgroundColor: colorTable[widget.nikka.color],
                    child: Icon(Icons.exposure_minus_1),
                  )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
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
          color: Colors.white,
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                margin: EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: colorTable[widget.nikka.color],
                ),
                child: Text(
                  (logs.length - count).toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                DateFormat('yyyy/MM/dd')
                    .format(DateTime.parse(logs[count].date)),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
