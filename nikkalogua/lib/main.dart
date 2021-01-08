import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        //home: RandomWords(),
        //home: newMethod(),
        home: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(color: Colors.blue, width: 100, height: 100),
                  Container(color: Colors.red, width: 100, height: 100),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(color: Colors.green, width: 100, height: 100),
                  Container(color: Colors.orange, width: 100, height: 100),
                ],
              ),
            ],
          ),
        ));
  }

  // for container test
  Scaffold newMethod() {
    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.blue,
            width: 300,
            height: 300,
            child: Text('word'),
            padding: const EdgeInsets.only(top: 50.0),
            margin: const EdgeInsets.only(left: 100.0),
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(0.1)),
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Startup Name Generator')),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(title: Text(pair.asPascalCase, style: _biggerFont));
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
