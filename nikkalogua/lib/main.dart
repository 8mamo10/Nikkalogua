import 'dart:math';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nikkalogua/ClientsBloc.dart';
import 'package:nikkalogua/ClientModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Nikkalogua';

  final list = [
    _cardItem('hoge'),
    _cardItem('fuga'),
    _cardItem('foo'),
    _cardItem('bar'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(_title),
          ),
          //body: MyStatelessWidget()),
          body: GridView.count(
            crossAxisCount: 2,
            children: list,
          ),
        ));
  }
}

Widget _cardItem(String name) {
  return Card(
    margin: const EdgeInsets.all(10.0),
    child: Container(
      width: 200,
      height: 200,
      child: Text(
        name,
        style: TextStyle(fontSize: 30),
      ),
    ),
  );
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  final List<String> _examples = ["hoge", "fuga", "foo", "bar"];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _examples
          .map(
            (String example) => Card(
              margin: const EdgeInsets.all(10.0),
              child: Container(
                width: 200,
                height: 200,
                child: Text(
                  example,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

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
