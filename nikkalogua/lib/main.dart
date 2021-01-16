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
    var grid = [
      "pic0.jpg",
      "pic1.jpg",
      "pic2.jpg",
      "pic3.jpg",
    ];
    return MaterialApp(
        //home: RandomWords(),
        home: Scaffold(
      appBar: AppBar(title: Text('GridView')),
      body: GridView.builder(
        //scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index >= grid.length) {
            grid.addAll(["pic0.jpg", "pic1.jpg", "pic2.jpg", "pic3.jpg"]);
          }
          return _photoItem(grid[index]);
        },
      ),
    ));
  }
}

Widget _photoItem(String image) {
  var assetImage = "assets/img/" + image;
  return Container(child: Image.asset(assetImage, fit: BoxFit.cover));
}

Widget _messageItem(String title) {
  return Container(
    width: 100,
    decoration: new BoxDecoration(
        border: new Border(right: BorderSide(width: 1.0, color: Colors.grey))),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    ),
  );
}

Widget _menuitem(String title, Icon icon) {
  return Container(
    decoration: new BoxDecoration(
        border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
    child: ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 18.0),
      ),
      onTap: () {
        print("onTap called");
      },
      onLongPress: () {
        print("onLongPress called");
      },
    ),
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
