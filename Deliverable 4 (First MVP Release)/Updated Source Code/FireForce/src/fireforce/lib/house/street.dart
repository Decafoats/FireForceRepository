import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fireforce/generic/navbar.dart';

class StreetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: NavbarWidget(title: 'Finding Your Street Name').build(context),
          body: StreetPageWidget(),
        )
    );
  }
}

class StreetPageWidget extends StatefulWidget{
  @override
  StreetPage createState() => StreetPage();
}

class StreetPage extends State<StreetPageWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFff7944), Color(0xFFf5326f)])),
    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
    width: double.infinity,
    child: Column(
    children: <Widget>[
      Image.asset('assets/images/house.png'),
      Padding(
        padding: EdgeInsets.only(top: 25),
        child: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: 'This is where you\'ll see your house number, combine this with the street name on the next screen!',
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0, color: Colors.white)),
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 70, left: 250),
        child: Icon(
          Icons.arrow_right,
          color: Colors.white,
          size: 100,
        ),
      )
    ],
    ),
      ),
    );
  }
}