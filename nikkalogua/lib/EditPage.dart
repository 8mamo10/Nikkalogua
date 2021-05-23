import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    String _nikkaName;

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
              children: <Widget>[
                Text("習慣にしたいことは何ですか？"),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '習慣を入力',
                  ),
                  onSaved: (value) {
                    _nikkaName = value;
                  },
                ),
                FlatButton(
                  child: Text("完了"),
                  color: Theme.of(context).buttonColor,
                  onPressed: () {
                    _form.currentState.save();
                    print(_nikkaName);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
