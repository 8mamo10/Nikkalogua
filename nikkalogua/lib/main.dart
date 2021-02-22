import 'dart:math';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nikkalogua/ClientsBloc.dart';
import 'package:nikkalogua/ClientModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String _title = 'Nikkalogua';

  //var _list = <Widget>[];
  var _nameList = <String>['str1', 'str2', 'str3', 'str4'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        //body: MyPage()),
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == _nameList.length) {
              return _cardPlus();
            } else {
              return _cardItem(_nameList[index]);
            }
          },
          itemCount: _nameList.length + 1,
        ),
        /*
        body: FutureBuilder(
          future: _getGrids(),
          builder: (BuildContext context, AsyncSnapshot<GridView> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Container(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              return snapshot.data;
            } else {
              return Container(
                child: Text('hoge'),
              );
            }
          },
        ),
        */
      ),
    );
  }

  Widget _cardItem(String name) {
    return GestureDetector(
        onTap: () => print(name),
        child: Card(
          margin: const EdgeInsets.all(10.0),
          child: Container(
            width: 200,
            height: 200,
            child: Text(
              name,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ));
  }

  Widget _cardPlus() {
    return IconButton(
      iconSize: 150,
      icon: Icon(Icons.add),
      onPressed: _handlePlus,
    );
  }

  void _handlePlus() {
    setState(() {
      _nameList.add(Random().nextInt(100).toString());
    });
  }
/*
  Future<GridView> _getGrids() async {
    return Future<GridView>.value(
        GridView.count(crossAxisCount: 2, children: _list));
  }
  */
}

///// bloc
class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  List<Client> testClients = [
    Client(firstName: "AAA", lastName: "BBB(default unblock)", blocked: false),
    Client(firstName: "CCC", lastName: "DDD(default block)", blocked: true),
    Client(firstName: "EEE", lastName: "FFF(default unblock)", blocked: false),
    Client(firstName: "GGG", lastName: "HHH(default block)", blocked: true),
  ];

  final bloc = ClientsBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter SQLite'),
      ),
      body: StreamBuilder<List<Client>>(
          stream: bloc.clients,
          builder:
              (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Client item = snapshot.data[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      bloc.delete(item.id);
                    },
                    child: ListTile(
                      title: Text(item.lastName),
                      leading: Text(item.id.toString()),
                      trailing: Checkbox(
                        onChanged: (bool value) {
                          item.blocked = value;
                          bloc.blockUnblock(item);
                          setState(() {});
                        },
                        value: item.blocked,
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              Client rnd = testClients[Random().nextInt(testClients.length)];
              bloc.add(rnd);
              setState(() {});
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.delete),
            onPressed: () async {
              bloc.deleteAll();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
