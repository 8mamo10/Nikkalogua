import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          color: ThemeData.light().backgroundColor,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text(
              'Setting',
            ),
            actions: <Widget>[
              IconButton(
                iconSize: 32,
                icon: Icon(
                  Icons.bedtime,
                  color: Colors.white,
                ),
                onPressed: () {
                  print("pressed");
                },
              ),
            ],
          ),
          body: ListView(
            children: [
              _menuItem('menu1', Icon(Icons.settings)),
              _menuItem('menu2', Icon(Icons.map)),
              _menuItem('menu3', Icon(Icons.room)),
              _menuItem('menu4', Icon(Icons.local_shipping)),
              _menuItem('menu5', Icon(Icons.airplanemode_active)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _menuItem(String title, Icon icon) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(
                10.0,
              ),
              child: icon,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
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
