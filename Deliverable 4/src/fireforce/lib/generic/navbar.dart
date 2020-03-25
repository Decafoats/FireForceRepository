import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  final String _title;

  NavbarWidget({title}) : _title = title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFff7944),
                  Color(0xFFf5326f),
                  Color(0xFFff7944)
                ])),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                _title,
                style: TextStyle(fontSize: 25, color: Colors.white),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.5),
              child:
              Image.asset("assets/images/fire.png", width: 35, height: 35)
            //child: Icon(nav_bar_icons.MyFlutterApp.fire,
            //    size: 28, color: Colors.orange),
          )
        ],
      ),
      actions: <Widget>[],
    );
  }
}