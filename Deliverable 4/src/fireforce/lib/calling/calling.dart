import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fireforce/generic/animations/fade_animations.dart';
import 'package:fireforce/generic/navbar.dart';
import 'package:fireforce/phone/phone_speech.dart';
import 'package:fireforce/generic/timer.dart';

class CallingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: NavbarWidget(title: 'Talking to 911').build(context),
      body: CallingPageWidget(),
    ));
  }
}

class CallingPageWidget extends StatefulWidget {
  @override
  CallingPage createState() => CallingPage();
}

class CallingPage extends State<CallingPageWidget> {
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
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: Image.asset('assets/images/fireman.png'),
          ),
          Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.phone_android,
                    color: Colors.white,
                    size: 32,
                  ),
                  TimerWidget(
                    timerSize: 32.0,
                    timerColor: Colors.white,
                  ),
                ],
              )),
          FadeHorizontalAnimationWidget(
              delay: 1.0,
              child: GridView.count(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: [
                    {'icon': Icons.mic_off, 'text': 'Mic'},
                    {'icon': Icons.grid_on, 'text': 'Grid'},
                    {'icon': Icons.volume_up, 'text': 'Volume'},
                    {'icon': Icons.trending_up, 'text': 'Up'},
                    {'icon': Icons.video_call, 'text': 'Video'},
                    {'icon': Icons.people, 'text': 'Contact'},
                  ]
                      .map((item) => GestureDetector(
                          onTap: () => {},
                          child: Column(
                            children: <Widget>[
                              Card(
                                  color: Colors.redAccent,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.0,
                                          bottom: 15.0,
                                          right: 22.0,
                                          left: 22.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              item['icon'],
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                            Text(
                                              item['text'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            )
                                          ]))),
                            ],
                          )))
                      .toList())),
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.phone_in_talk,
            color: Colors.white,
            size: 50,
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FadeVerticalAnimationWidget(
                      delay: 0.8,
                      child: PhoneSpeechWidget(
                        text: 'Your talking to the cops kid!',
                        icon: Icons.people_outline,
                        color: Colors.greenAccent,
                        textColor: Colors.black87,
                      )))),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}
