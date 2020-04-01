import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fireforce/generic/navbar.dart';
import 'package:fireforce/house/street.dart';

class HouseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: NavbarWidget(title: 'Finding Your House #').build(context),
        body: HousePageWidget(),
      )
    );
  }
}

class HousePageWidget extends StatefulWidget{
  @override
  HousePage createState() => HousePage();
}

class HousePage extends State<HousePageWidget>{
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
            padding: EdgeInsets.only(top: 65, left: 200),
            child: IconButton(
             icon: Icon(Icons.arrow_forward, size: 70),
              color: Colors.white,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StreetWidget()),
                );
              }
            ),
          ),
        ],
      ),
      ),
    );
  }
}


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
            Image.asset('assets/images/street.png'),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'This is where you\'ll see your street name! Pick the street name that your house is on, along the direction of the sign! In this case, we\'ll pick Rae Street!\n\n',
                        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5, color: Colors.white)),
                    TextSpan(text: 'Therefore, the address is 2661 Rae Street!',
                        style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, right: 250),
    child: IconButton(
        icon: Icon(Icons.arrow_back, size: 70),
        color: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HouseWidget()),
          );
        }
        ),
            ),
          ],
        ),
      ),
    );
  }
}