import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:nikkalogua/Common.dart';
import 'package:nikkalogua/Database.dart';
import 'package:nikkalogua/LogModel.dart';

class CardPage extends StatefulWidget {
  final Map nikkaAndLogs;
  final now = new DateFormat("yyyy-MM-dd").format(DateTime.now());
  CardPage(this.nikkaAndLogs);

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
          widget.nikkaAndLogs['nikka'].name,
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (int i = 0; i < widget.nikkaAndLogs['logs'].length; i++)
                _dailyLine(widget.nikkaAndLogs['logs'].length, i)
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: widget.nikkaAndLogs["logs"].first.date != widget.now,
        child: FloatingActionButton(
          heroTag: "AddLog",
          onPressed: () {
            setState(() {
              DBProvider.db.newLog(Log(
                nikkaId: widget.nikkaAndLogs["nikka"].id,
                date: widget.now,
              ));
            });
          },
          backgroundColor: colorTable[widget.nikkaAndLogs['nikka'].color],
          child: Icon(Icons.plus_one),
        ),
      ),
    );
  }

  Widget _dailyLine(int total, int count) {
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
                  color: colorTable[widget.nikkaAndLogs['nikka'].color],
                ),
                child: Text(
                  (total - count).toString(),
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
                DateFormat('yyyy/MM/dd').format(
                    DateTime.parse(widget.nikkaAndLogs['logs'][count].date)),
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
