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
            body: Stack(
              children: <Widget>[
                GridView.builder(
                  //scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= grid.length) {
                      grid.addAll(
                          ["pic0.jpg", "pic1.jpg", "pic2.jpg", "pic3.jpg"]);
                    }
                    return _photoItem(grid[index]);
                  },
                ),
                // Container(
                //   width: 100,
                //   height: 100,
                //   color: Colors.green,
                // ),
                // Container(
                //   width: 50,
                //   height: 80,
                //   color: Colors.orange,
                // ),
                // Positioned(
                //     left: 120,
                //     top: 120,
                //     width: 100,
                //     height: 100,
                //     child: Container(color: Colors.blue)),
                // Card(
                //   margin: const EdgeInsets.all(50.0),
                //   child: Container(
                //     margin: const EdgeInsets.all(10.0),
                //     width: 300,
                //     height: 100,
                //     child: Text(
                //       'Card',
                //       style: TextStyle(fontSize: 30),
                //     ),
                //   ),
                // ),
                // ClickGood(),
                // ChangeForm(),
                // PopupMenuButton<String>(
                //   itemBuilder: (BuildContext context) =>
                //       <PopupMenuEntry<String>>[
                //     const PopupMenuItem<String>(
                //       value: "1",
                //       child: Text('select1'),
                //     ),
                //     const PopupMenuItem<String>(
                //       value: "2",
                //       child: Text('select2'),
                //     ),
                //   ],
                // ),
                // ChangeForm2(),
                ChangeForm3(),
              ],
            )));
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

class ClickGood extends StatefulWidget {
  @override
  _ClickGoodState createState() => _ClickGoodState();
}

class _ClickGoodState extends State<ClickGood> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _handleTap,
        child: Container(
          child: Center(
              child: new Icon(
            Icons.thumb_up,
            color: _active ? Colors.orange[700] : Colors.grey[500],
            size: 100.0,
          )),
        ));
  }
}

class ChangeForm extends StatefulWidget {
  @override
  _ChangeFormState createState() => _ChangeFormState();
}

class _ChangeFormState extends State<ChangeForm> {
  int _count = 0;
  void _handlePressed() {
    setState(() {
      _count++;
    });
  }

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            Text(
              "$_count",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            FloatingActionButton(
              onPressed: _handlePressed,
              backgroundColor: Colors.blue,
              child: Icon(Icons.add),
            ),
          ],
        ));
  }
}

class ChangeForm2 extends StatefulWidget {
  @override
  _ChangeForm2State createState() => _ChangeForm2State();
}

class _ChangeForm2State extends State<ChangeForm2> {
  String _text = "";
  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: <Widget>[
          Text(
            "$_text",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 30.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          new TextField(
            enabled: true,
            maxLength: 10,
            maxLengthEnforced: false,
            style: TextStyle(color: Colors.red),
            obscureText: false,
            maxLines: 1,
            onChanged: _handleText,
          ),
        ],
      ),
    );
  }
}

class ChangeForm3 extends StatefulWidget {
  @override
  _ChangeForm3State createState() => _ChangeForm3State();
}

class _ChangeForm3State extends State<ChangeForm3> {
  bool _flag = false;
  void _handleCheckBox(bool e) {
    setState(() {
      _flag = e;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: <Widget>[
          Center(
            child: new Icon(
              Icons.thumb_up,
              color: _flag ? Colors.orange[700] : Colors.grey[500],
              size: 100.0,
            ),
          ),
          new Checkbox(
            activeColor: Colors.blue,
            value: _flag,
            onChanged: _handleCheckBox,
          ),
          new CheckboxListTile(
            activeColor: Colors.blue,
            title: Text('checkbox'),
            subtitle: Text('subtitle'),
            secondary: new Icon(
              Icons.thumbs_up_down,
              color: _flag ? Colors.orange[700] : Colors.grey[500],
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: _flag,
            onChanged: _handleCheckBox,
          ),
        ],
      ),
    );
  }
}
