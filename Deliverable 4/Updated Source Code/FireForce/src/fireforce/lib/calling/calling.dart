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
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 35.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: Image.asset('assets/images/fireman.png'),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10),
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
                    {'icon': Icons.mic_off},
                    {'icon': Icons.grid_on},
                    {'icon': Icons.volume_up},
                    {'icon': Icons.trending_up},
                    {'icon': Icons.video_call},
                    {'icon': Icons.people},
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
                                          ]))),
                            ],
                          )))
                      .toList())),
          SizedBox(
            height: 10,
          ),
          Icon(
            Icons.phone_in_talk,
            color: Colors.white,
            size: 50,
          ),
          Expanded(
              child: Align(
                  alignment: Alignment(0.0, 5),
                  child: FadeVerticalAnimationWidget(
                      delay: 0.8,
                      child: PhoneSpeechWidget(
                        text: 'You are now talking to the police.',
                        icon: Icons.people_outline,
                        color: Colors.greenAccent,
                        textColor: Colors.black87,
                       )))),
          Padding(
            padding: EdgeInsets.only(bottom: 20, left: 200),
            child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScriptWidget()),
                  );
                },
                textColor: Colors.white,
              color: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.all(5.0),
                  child: const Text(
                      'Script',
                      style: TextStyle(fontSize: 18)
                  ),
              ),
            ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}

class ScriptWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: NavbarWidget(title: 'Script').build(context),
          body: ScriptPageWidget(),
        )
    );
  }
}

class ScriptPageWidget extends StatefulWidget{
  @override
  ScriptPage createState() => ScriptPage();
}

class ScriptPage extends State<ScriptPageWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFff7944), Color(0xFFf5326f)])),
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 9,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'Dispatch: One Moment. Regina Fire Department. How may I help you?\n\n'
                        'Caller: There is a fire in my house.\n\n'
                        'Dispatch: What is your address?\n\n'
                        'Caller: My address is (house number) + (street name)\n\n'
                        'Dispatch: Is anyone still in the house? Have you all met at a meeting point?\n\n'
                        'Caller: [Yes/No] there [are/are\'nt] people in the house. We [have/have\'nt] met at a meeting point.\n\n'
                        'Dispatch: What is your phone number?\n\n'
                        'Caller: My phone number is (---) ---- ----\n\n'
                        'Dispatch: Ok, the fire trucks are on their way. Don\'t go back into the house.',
                        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3, color: Colors.white)),
                  ],
                ),
              ),
            ),
           Flexible(
             flex: 1,
           child: Align(
              alignment: Alignment.bottomLeft,
             child: RaisedButton(
               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => CallingWidget()),
                 );
               },
               textColor: Colors.white,
               color: Colors.deepOrangeAccent,
               padding: const EdgeInsets.all(5.0),
               child: const Text(
                   'Back',
                   style: TextStyle(fontSize: 18)
               ),
             ),
            ),
               )
          ],
        ),
      ),
    );
  }
}