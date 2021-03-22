import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Setting',
      )),
      body: ListView(
        children: [
          _menuItem('menu1', Icon(Icons.settings)),
          _menuItem('menu2', Icon(Icons.map)),
          _menuItem('menu3', Icon(Icons.room)),
          _menuItem('menu4', Icon(Icons.local_shipping)),
          _menuItem('menu5', Icon(Icons.airplanemode_active)),
        ],
      ),
    );
  }

  Widget _menuItem(String title, Icon icon) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1.0,
          color: Colors.grey,
        ))),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(
                10.0,
              ),
              child: icon,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
          ],
        ),
      ),
      onTap: () {
        print(title + ': under construction');
      },
    );
  }
}
