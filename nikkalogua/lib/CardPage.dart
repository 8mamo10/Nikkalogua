import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardPage extends StatelessWidget {
  final String paramText;

  CardPage({
    Key key,
    @required this.paramText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          paramText,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[for (int i = 0; i < 5; i++) _dailyLine()],
        ),
      ),
    );
  }

  Widget _dailyLine() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 100.0),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        child: Text(
          this.paramText,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
