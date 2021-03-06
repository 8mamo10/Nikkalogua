import 'package:flutter/material.dart';
import 'package:nikkalogua/CardListPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Nikkalogua';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: CardListPage(),
    );
  }
}
