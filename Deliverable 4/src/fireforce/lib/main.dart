import 'package:fireforce/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animation_set/widget/behavior_animations.dart';
import 'package:flutter/services.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:fireforce/escape_planning/escape_planning.dart';
import 'package:fireforce/info/info.dart';
import 'package:fireforce/phone/phone.dart';
import 'package:fireforce/qa/qa.dart';
import 'package:fireforce/generic/navbar.dart';
import 'package:fireforce/generic/animations/fade_animations.dart';
import 'package:fireforce/main/bloc/main_bloc.dart';
import 'package:fireforce/main/bloc/main_repo.dart';
import 'package:fireforce/generic/speech_animated.dart';

void main() => runApp(SplashWidget());

class MyAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        home: Scaffold(
      appBar: NavbarWidget(title: 'Fire Force').build(context),
      body: BlocProvider(
          builder: (context) => MainBloc(MainRepo()),
          child: ShowCaseWidget(
              builder: Builder(builder: (context) => MainPageWidget()))),
    ));
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPageWidget> {
  MainBloc _bloc;
  final GlobalKey _safetyTipOverlayKey = GlobalKey();
  final GlobalKey _gridOverlayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    //Start showcase view after current widget frames are drawn.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => Future.delayed(Duration(seconds: 1), () {
              ShowCaseWidget.of(context)
                  .startShowCase([_safetyTipOverlayKey, _gridOverlayKey]);
            }));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<MainBloc>(context);
    _bloc.add(MainUpdateEvent());

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Showcase.withWidget(
            key: _safetyTipOverlayKey,
            animationDuration: Duration(milliseconds: 1500),
            textColor: Colors.grey,
            width: 90,
            container: Container(
                color: Colors.transparent,
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'A new tip will be posted here everyday about fire safety.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                )),
            child: Stack(
              children: <Widget>[
                FadeVerticalAnimationWidget(delay: 1.5, child: YYLove()),
                FadeHorizontalAnimationWidget(
                    delay: 1.5,
                    child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/dog.png'))),
                        ))),
                Container(
                    child: Column(
                  children: <Widget>[
                    FadeVerticalAnimationWidget(
                        delay: 1.5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            'Safety Tip of the day!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 26),
                          ),
                        )),
                    BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                      if (state is MainLoadedState) {
                        return FadeHorizontalAnimationWidget(
                            delay: 1.0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 100, top: 8),
                              child: SpeechAnimatedWidget(
                                textColor: Colors.black87,
                                icon: Icons.info_outline,
                                text: state.getViewModel.getHelpTip,
                                iconColor: Colors.red,
                              ),
                            ));
                      }
                      return Text('');
                    }),
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Showcase.withWidget(
            key: _gridOverlayKey,
            animationDuration: Duration(milliseconds: 1500),
            textColor: Colors.grey,
            width: 90,
            container: Container(
                color: Colors.transparent,
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Icon(
                            Icons.touch_app,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Tap on one of the tiles in this box to go to another screen.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                )),
            child: FadeVerticalAnimationWidget(
                delay: 2.5,
                child: GridView.count(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    padding: const EdgeInsets.all(4.0),
                    mainAxisSpacing: 30.0,
                    crossAxisSpacing: 10.0,
                    children: [
                      {'icon': Icons.home, 'title': 'House'},
                      {'icon': Icons.phone, 'title': '911 Phone'},
                      {'icon': Icons.question_answer, 'title': 'Quiz'},
                      {'icon': Icons.directions_run, 'title': 'Escape Plan'}
                    ]
                        .map((item) => GestureDetector(
                            onTap: () => GetTileByIcon(context, item['icon']),
                            child: Card(
                                color: Colors.redAccent,
                                //elevation: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      item['icon'],
                                      size: 46.0,
                                      color: Colors.white,
                                    ),
                                    Text(item['title'],
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white))
                                  ],
                                ))))
                        .toList())),
          )
        ],
      ),
    ));
  }

  // redirect to other page routes based on tile selected
  GetTileByIcon(BuildContext context, IconData data) {
    if (data == Icons.phone) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => PhoneWidget()));
    } else if (data == Icons.info) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => InfoWidget()));
    } else if (data == Icons.question_answer) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => QAWidget()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => EscapeWidget()));
    }
  }
}
