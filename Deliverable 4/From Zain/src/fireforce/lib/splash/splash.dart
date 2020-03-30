import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fireforce/generic/animations/liquid_text_animation.dart';
import 'package:fireforce/main.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SplashPageWidget(),
    ));
  }
}

class SplashPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.red),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 30, left: 15.0),
                  child: Container(width: MediaQuery.of(context).size.width / 1.1, child:Text(
                    'Fire force is a fire safety application for kids. Kids will learn how to call 911 and what to expect and say when talking to the emergency operators.',
                    style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ))),
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Colors.white),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height / 2) - 160.0,
                right: 5,
                child: Image(
                  image: AssetImage('assets/images/dog_stand_thug.png'),
                  fit: BoxFit.cover,
                  height: 250.0,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height / 2) - 100.0,
                      right: 5.0),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/fire.png'))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height / 2) - 40.0,
                      left: 15.0),
                  child: Text(
                    'Fire Force',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2 + 10.0, left: 15.0),
                  child: Container(width: 150, child:Text(
                    'Regina Fire & Protective Services has been an integral part of Regina and area since 1882',
                    style: TextStyle(
                      letterSpacing: 1,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ))),
              Positioned.fill(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 25),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 125,
                          child: AnimatedLiquidLinearProgressIndicatorWidget(
                            liquidColor: Colors.red,
                            textColor: Colors.black,
                            borderColor: Colors.red,
                            backgroundColor: Colors.white,
                            textSize: 16.0,
                            duration: Duration(seconds: 8),
                            callback: (status) => {
                              if (status == AnimationStatus.completed)
                                {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyAppWidget()))
                                }
                            },
                          ),
                        ))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
