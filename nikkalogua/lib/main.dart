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
        home: Scaffold(
            appBar: AppBar(title: Text('ListView')),
            body: ListView(
              children: [
                _menuitem("menu1", Icon(Icons.settings)),
                _menuitem("menu2", Icon(Icons.map)),
                _menuitem("menu3", Icon(Icons.room)),
                _menuitem("menu4", Icon(Icons.local_shipping)),
                _menuitem("menu4", Icon(Icons.airplanemode_active)),
              ],
            )));
  }
}

Widget _menuitem(String title, Icon icon) {
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.all(8.0),
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: icon,
          ),
          Text(title, style: TextStyle(color: Colors.black, fontSize: 18.0))
        ],
      ),
    ),
    onTap: () {
      print("onTap called");
    },
  );
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
