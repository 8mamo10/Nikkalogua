import 'package:flutter/material.dart';
import 'package:nikkalogua/Common.dart';
import 'package:nikkalogua/Database.dart';
import 'package:nikkalogua/NikkaModel.dart';

class EditPage extends StatefulWidget {
  final Nikka _nikka;
  EditPage(this._nikka);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _form = GlobalKey<FormState>();

  String _name = "";
  int _color = 0;

  @override
  void initState() {
    this._color = widget._nikka == null ? 0 : widget._nikka.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).backgroundColor,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "習慣にしたいことは何ですか？",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    initialValue:
                        widget._nikka == null ? null : widget._nikka.name,
                    decoration: InputDecoration(
                      hintText: '習慣を入力',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "習慣を入力してください。";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(
                        () {
                          this._name = value;
                        },
                      );
                    },
                  ),
                ),
                Text(
                  "何色で表示しますか？",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: DropdownButton<int>(
                    value: this._color,
                    items: colorTable.asMap().keys.map(
                      (int index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                color: colorTable[index],
                                margin: EdgeInsets.all(3),
                              ),
                              Text(index.toString()),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (int color) {
                      setState(() {
                        this._color = color;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: ElevatedButton(
                    child: Text("完了"),
                    onPressed: () {
                      setState(
                        () {
                          if (_form.currentState.validate()) {
                            _form.currentState.save();
                            Nikka nikka = Nikka(
                              name: this._name,
                              color: this._color,
                            );
                            if (widget._nikka == null) {
                              DBProvider.db.newNikka(nikka);
                            } else {
                              nikka.id = widget._nikka.id;
                              DBProvider.db.updateNikka(nikka);
                            }
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
