import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardPage extends StatelessWidget {
  final Map params;
  final now = DateTime.now();

  CardPage({
    Key key,
    @required this.params,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          params['name'],
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (int i = 0; i < this.params['count']; i++)
                _dailyLine(this.params['count'], i)
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: this.params['color'],
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
                  color: this.params['color'],
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
                //this.params['name'],
                DateFormat('yyyy/MM/dd')
                    .format(now.subtract(new Duration(days: count))),
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
