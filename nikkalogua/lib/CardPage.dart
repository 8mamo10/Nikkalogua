import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardPage extends StatelessWidget {
  final String paramText;

  CardPage({Key key, @required this.paramText}) : super(key: key);

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
        child: Text(
          this.paramText,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
