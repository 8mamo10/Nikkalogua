import 'dart:math';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nikkalogua/ClientsBloc.dart';
import 'package:nikkalogua/ClientModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Nikkalogua';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
          appBar: AppBar(title: const Text(_title)), body: MyStatelessWidget()),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('hoge'),
              subtitle: Text('fuga'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('button1'),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('button2'),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
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
