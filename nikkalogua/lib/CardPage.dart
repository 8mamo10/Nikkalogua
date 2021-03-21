import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardPage extends StatelessWidget {
  final Map params;

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
        margin: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (int i = this.params['count']; i > 0; i--) _dailyLine(i)
            ],
          ),
        ),
      ),
    );
  }

  Widget _dailyLine(int count) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 100.0),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                margin: EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: this.params['color'],
                ),
                child: Text(
                  count.toString(),
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
                this.params['name'],
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
