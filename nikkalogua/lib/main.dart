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
    // var grid = [
    //   "pic0.jpg",
    //   "pic1.jpg",
    //   "pic2.jpg",
    //   "pic3.jpg",
    // ];
    return MaterialApp(
      //home: RandomWords(),
      //home: MainPage(),
      //home: MainPage2(),
      //home: MainPage3(),
      /*
        home: Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.menu),
              title: const Text('Nikkalogua'),
              backgroundColor: Colors.orange,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.face, color: Colors.white),
                ),
                IconButton(
                  icon: Icon(Icons.email, color: Colors.white),
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.white),
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                // GridView.builder(
                //   //scrollDirection: Axis.horizontal,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     mainAxisSpacing: 4,
                //     crossAxisSpacing: 4,
                //     childAspectRatio: 0.7,
                //   ),
                //   itemBuilder: (BuildContext context, int index) {
                //     if (index >= grid.length) {
                //       grid.addAll(
                //           ["pic0.jpg", "pic1.jpg", "pic2.jpg", "pic3.jpg"]);
                //     }
                //     return _photoItem(grid[index]);
                //   },
                // ),
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
                //ChangeForm(),
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
                //ChangeForm2(),
                //ChangeForm3(),
                //ChangeForm4(),
                //ChangeForm5(),
                //ChangeForm6(),
                //ChangeForm7(),
              ],
            )
            )
            */
      home: TheMainPage(),
/*         routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new TheMainPage(),
          '/subpage': (BuildContext context) => new TheSubPage(),
        } */
    );
  }
}

class TheMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Navigator'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Text('Main'),
              RaisedButton(
                //onPressed: () => Navigator.of(context).pushNamed('/subpage'),
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TheSubPage();
                })),
                child: new Text('To subpage'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TheSubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Navigator'),
      ),
      body: new Container(
        padding: EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Text('Sub'),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('Return'),
              )
            ],
          ),
        ),
      ),
    );
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

class ChangeForm4 extends StatefulWidget {
  @override
  _ChangeForm4State createState() => _ChangeForm4State();
}

class _ChangeForm4State extends State<ChangeForm4> {
  bool _active = false;
  void _changeSwitch(bool e) => setState(() => _active = e);
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Center(
              child: new Icon(
                Icons.thumb_up,
                color: _active ? Colors.orange[700] : Colors.grey[500],
                size: 100.0,
              ),
            ),
            new Switch(
              value: _active,
              activeColor: Colors.orange,
              activeTrackColor: Colors.red,
              inactiveThumbColor: Colors.blue,
              inactiveTrackColor: Colors.green,
              onChanged: _changeSwitch,
            ),
          ],
        ));
  }
}

class ChangeForm5 extends StatefulWidget {
  @override
  _ChangeForm5State createState() => _ChangeForm5State();
}

class _ChangeForm5State extends State<ChangeForm5> {
  double _value = 0.0;
  double _startValue = 0.0;
  double _endValue = 0.0;

  void _changeSlider(double e) => setState(() {
        _value = e;
      });
  void _startSlider(double e) => setState(() {
        _startValue = e;
      });
  void _endSlider(double e) => setState(() {
        _endValue = e;
      });
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: [
          Center(child: Text("Current:$_value")),
          Center(child: Text("Start:$_startValue")),
          Center(child: Text("End:$_endValue")),
          new Slider(
            label: '$_value',
            min: 0,
            max: 10,
            value: _value,
            activeColor: Colors.orange,
            inactiveColor: Colors.blueAccent,
            divisions: 10,
            onChanged: _changeSlider,
            onChangeStart: _startSlider,
            onChangeEnd: _endSlider,
          ),
        ],
      ),
    );
  }
}

class ChangeForm6 extends StatefulWidget {
  @override
  _ChangeForm6State createState() => _ChangeForm6State();
}

class _ChangeForm6State extends State<ChangeForm6> {
  DateTime _date = new DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now().add(new Duration(days: 360)));
    if (picked != null)
      setState(() {
        _date = picked;
      });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Text("$_date"),
          ),
          new RaisedButton(
            onPressed: () => _selectDate(context),
            child: new Text('select'),
          )
        ],
      ),
    );
  }
}

class ChangeForm7 extends StatefulWidget {
  @override
  _ChangeForm7State createState() => _ChangeForm7State();
}

class _ChangeForm7State extends State<ChangeForm7> {
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null)
      setState(() {
        _time = picked;
      });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Text("$_time"),
          ),
          new RaisedButton(
            onPressed: () => _selectTime(context),
            child: new Text('select'),
          )
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final _pageWidgets = [
    PageWidget(color: Colors.white, title: 'Home'),
    PageWidget(color: Colors.blue, title: 'Album'),
    PageWidget(color: Colors.orange, title: 'Chat'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar'),
      ),
      body: _pageWidgets.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_album), label: 'Photo'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index);
}

class PageWidget extends StatelessWidget {
  final Color color;
  final String title;

  PageWidget({Key key, this.color, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

class MainPage2 extends StatefulWidget {
  @override
  _MainPage2State createState() => _MainPage2State();
}

class _MainPage2State extends State<MainPage2> {
  final _tab = <Tab>[
    Tab(text: 'Car', icon: Icon(Icons.directions_car)),
    Tab(text: 'Bicycle', icon: Icon(Icons.directions_bike)),
    Tab(text: 'Boat', icon: Icon(Icons.directions_boat)),
  ];

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tab.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar'),
          bottom: TabBar(
            tabs: _tab,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TabPage(title: 'Car', icon: Icons.directions_car),
            TabPage(title: 'Cicycle', icon: Icons.directions_bike),
            TabPage(title: 'Boat', icon: Icons.directions_boat),
          ],
        ),
      ),
    );
  }
}

class TabPage extends StatelessWidget {
  final IconData icon;
  final String title;

  const TabPage({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 64.0, color: textStyle.color),
          Text(title, style: textStyle),
        ],
      ),
    );
  }
}

class MainPage3 extends StatefulWidget {
  @override
  _MainPage3State createState() => _MainPage3State();
}

class _MainPage3State extends State<MainPage3> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item1'),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text('Item2'),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
