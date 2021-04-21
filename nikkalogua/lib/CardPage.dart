import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardPage extends StatelessWidget {
  final Map nikkaAndLogs;
  final now = DateTime.now();

  List _colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];

  CardPage({
    Key key,
    @required this.nikkaAndLogs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          nikkaAndLogs['nikka'].name,
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (int i = 0; i < this.nikkaAndLogs['logs'].length; i++)
                _dailyLine(this.nikkaAndLogs['logs'].length, i)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "AddLog",
        onPressed: () {
          print("+1 pressed");
        },
        backgroundColor: this._colors[nikkaAndLogs['nikka'].color],
        child: Icon(Icons.plus_one),
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
                  color: this._colors[this.nikkaAndLogs['nikka'].color],
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
                    DateTime.parse(this.nikkaAndLogs['logs'][count].date)),
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
