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
          color: Theme.of(context).backgroundColor,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text(
              'Setting',
            ),
            /*
            actions: <Widget>[
              IconButton(
                iconSize: 32,
                icon: Icon(
                  Icons.bedtime,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                onPressed: () {
                  print("pressed");
                },
              ),
            ],
            */
          ),
          body: ListView(
            children: [
              _menuItem('menu1', Icon(Icons.settings), context),
              _menuItem('menu2', Icon(Icons.map), context),
              _menuItem('menu3', Icon(Icons.room), context),
              _menuItem('menu4', Icon(Icons.local_shipping), context),
              _menuItem('menu5', Icon(Icons.airplanemode_active), context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _menuItem(String title, Icon icon, BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
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
              margin: EdgeInsets.all(
                10.0,
              ),
              child: icon,
            ),
            Text(
              title,
              style: TextStyle(
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
