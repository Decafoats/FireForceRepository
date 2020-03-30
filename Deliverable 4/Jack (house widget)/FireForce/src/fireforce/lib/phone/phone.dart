import 'package:fireforce/calling/calling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:fireforce/generic/navbar.dart';
import 'package:fireforce/phone/bloc/phone_bloc.dart';
import 'package:fireforce/generic/animations/touch_animation.dart';
import 'package:fireforce/generic/confetti.dart';
import 'package:fireforce/generic/animations/fade_animations.dart';
import 'package:fireforce/generic/music/music.dart';
import 'package:fireforce/phone/phone_grid.dart';
import 'package:fireforce/phone/phone_speech.dart';

class PhoneWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: NavbarWidget(title: '911 Call').build(context),
      body: BlocProvider(
          builder: (context) => PhoneBloc(),
          child: ShowCaseWidget(
              builder: Builder(
            builder: (context) => PhonePageWidget(),
          ))),
    ));
  }
}

class PhonePageWidget extends StatefulWidget {
  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePageWidget> {
  bool _hideHelper = false;
  bool _hidePressed = false;
  PhoneBloc _bloc;
  PhoneState _prevBlocState;

  final GlobalKey _emergencyOverlayKey = GlobalKey();
  final GlobalKey _gridOverlayKey = GlobalKey();
  final GlobalKey _currentlyEnteredNumbersOverlayKey = GlobalKey();
  final GlobalKey _dogeOverlayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Start showcase view after current widget frames are drawn.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => Future.delayed(Duration(seconds: 1), () {
              ShowCaseWidget.of(context).startShowCase([_emergencyOverlayKey]);
            }));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<PhoneBloc>(context);

    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFff7944), Color(0xFFf5326f)])),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<PhoneBloc, PhoneState>(builder: (context, state) {
            Widget header, grid, gridBottom, speechAnim;
            if (state is PhoneLockState) {
              playBark();
              header = Column(children: [
                FadeHorizontalAnimationWidget(
                    delay: 1.3,
                    child: Container(
                        child: Text(
                      'Enter Passcode',
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.remove_circle,
                      color: Colors.white,
                    ),
                    Icon(Icons.remove_circle, color: Colors.white),
                    Icon(Icons.remove_circle, color: Colors.white),
                    Icon(Icons.remove_circle, color: Colors.white),
                  ],
                )
              ]);
              grid = FadeHorizontalAnimationWidget(
                  delay: 1.0,
                  child: PhoneGridWidget(
                      callback: null, hintNeeded: false, nextNumber: 0));
              gridBottom = Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30, bottom: 20),
                      child: Showcase.withWidget(
                          key: _emergencyOverlayKey,
                          animationDuration: Duration(milliseconds: 1500),
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
                                          Icons.touch_app,
                                          color: Colors.white,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Tap to make an emergency call.',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              )),
                          child: GestureDetector(
                              onTap: () => {emergencyTapped(context, _bloc)},
                              child: Column(children: [
                                Text('Emergency',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                TouchAnimationWidget(
                                  startColor: Colors.white,
                                  endColor: Colors.white,
                                  iconColor: Colors.white,
                                  iconSize: 46.0,
                                  tapTextSize: 22.0,
                                ),
                              ]))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 45, bottom: 45),
                      child: Text('Lock',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    )
                  ]);
              speechAnim = Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FadeSoftAnimationWidget(
                          delay: 1.7,
                          child: PhoneSpeechWidget(
                            text: 'hey kid, press emergency to call 911!',
                            icon: Icons.phone_locked,
                            color: Colors.redAccent,
                            textColor: Colors.black87,
                          ),
                          key: UniqueKey())));
              return Expanded(
                  child: Column(
                children: <Widget>[
                  header,
                  grid,
                  gridBottom,
                  speechAnim,
                  SizedBox(height: 10)
                ],
              ));
            } else {
              gridBottom = Align(
                  alignment: Alignment.bottomLeft,
                  child: Showcase.withWidget(
                      key: _dogeOverlayKey,
                      animationDuration: Duration(milliseconds: 1500),
                      height: 100,
                      width: 100,
                      container: Container(
                          color: Colors.transparent,
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.touch_app,
                                      color: Colors.white,
                                    )),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Tap to hide the dog!',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ))
                            ],
                          )),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 35.0, right: 35.0),
                        textColor: Colors.white,
                        color: Colors.red,
                        elevation: 1,
                        onPressed: () => {hideButtonTapped(state)},
                        child: Text(_hideHelper ? "Show" : "Hide",
                            style: TextStyle(fontSize: 20)),
                      )));

              if (state is PhoneLoadedState) {
                header = Column(children: [
                  FadeHorizontalAnimationWidget(
                      delay: 1.3,
                      child: Container(
                          child: Text(
                        'Emergency',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ))),
                ]);

                grid = Showcase.withWidget(
                    key: _gridOverlayKey,
                    animationDuration: Duration(milliseconds: 1500),
                    height: 100,
                    width: 100,
                    container: Container(
                        color: Colors.transparent,
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.touch_app,
                                    color: Colors.white,
                                  )),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Tap a tile to dial a number.',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ))
                          ],
                        )),
                    child: PhoneGridWidget(
                        callback: (item) => {
                              gridButtonTapped(context, _bloc, item['d'], state)
                            },
                        hintNeeded: false,
                        nextNumber: 0));

                speechAnim = Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                            opacity: _hideHelper ? 0.0 : 1.0,
                            child: FadeVerticalAnimationWidget(
                                delay: 1.5,
                                child: PhoneSpeechWidget(
                                  text:
                                      'Welcome! Try to press the first digit!',
                                  icon: Icons.accessibility_new,
                                  color: Colors.blueAccent,
                                  textColor: Colors.black87,
                                ),
                                key: UniqueKey()))));

                return Expanded(
                    child: Column(
                  children: <Widget>[
                    header,
                    grid,
                    gridBottom,
                    speechAnim,
                    SizedBox(height: 10)
                  ],
                ));
              } else if (state is PhoneIncorrectState) {
                if (_prevBlocState != state) {
                  playIncorrect();
                  EdgeAlert.show(context,
                      icon: Icons.cancel,
                      title: 'Uh oh, that is incorrect. Try again!',
                      description: 'wrong digit',
                      backgroundColor: Colors.redAccent,
                      gravity: EdgeAlert.TOP);
                }

                header = Column(children: [
                  FadeHorizontalAnimationWidget(
                      delay: 1.3,
                      child: Container(
                          child: Text(
                        'Emergency',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ))),
                  Text(
                    state.getViewModel.getCurrentNumber == 0
                        ? ' '
                        : state.getViewModel.getCurrentNumber.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ]);

                grid = PhoneGridWidget(
                    callback: (item) =>
                        {gridButtonTapped(context, _bloc, item['d'], state)},
                    hintNeeded: false,
                    nextNumber: 0);

                speechAnim = Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                            opacity: _hideHelper ? 0.0 : 1.0,
                            child: FadeVerticalAnimationWidget(
                                delay: 1.5,
                                child: PhoneSpeechWidget(
                                  text:
                                      'Oops, that was incorrect! Try again',
                                  icon: Icons.clear,
                                  color: Colors.orangeAccent,
                                  textColor: Colors.black87,
                                ),
                                key: UniqueKey()))));
                return Expanded(
                    child: Column(
                  children: <Widget>[
                    header,
                    grid,
                    gridBottom,
                    speechAnim,
                    SizedBox(height: 10)
                  ],
                ));
              } else if (state is PhoneIncorrectSecondState) {
                if (_prevBlocState != state) {
                  playIncorrect();
                  EdgeAlert.show(context,
                      icon: Icons.cancel,
                      title: 'The number is wrong, please try again.',
                      description: 'wrong digit again',
                      backgroundColor: Colors.redAccent,
                      gravity: EdgeAlert.TOP);
                }

                header = Column(children: [
                  FadeHorizontalAnimationWidget(
                      delay: 1.3,
                      child: Container(
                          child: Text(
                        'Emergency',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ))),
                  Text(
                    state.getViewModel.getCurrentNumber == 0
                        ? ' '
                        : state.getViewModel.getCurrentNumber.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ]);

                grid = PhoneGridWidget(
                    callback: (item) =>
                        {gridButtonTapped(context, _bloc, item['d'], state)},
                    hintNeeded: false,
                    nextNumber: 0,
                    key: UniqueKey());

                speechAnim = Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                            opacity: _hideHelper ? 0.0 : 1.0,
                            child: FadeVerticalAnimationWidget(
                                delay: 0.8,
                                child: PhoneSpeechWidget(
                                  text: 'Fail again, wrong digit! Try again',
                                  icon: Icons.clear,
                                  color: Colors.orangeAccent,
                                  textColor: Colors.black87,
                                ),
                                key: UniqueKey()))));
                return Expanded(
                    child: Column(
                  children: <Widget>[
                    header,
                    grid,
                    gridBottom,
                    speechAnim,
                    SizedBox(height: 10)
                  ],
                ));
              } else if (state is PhoneIncorrectThirdState) {
                if (_prevBlocState != state) playIncorrect();

                header = Column(children: [
                  FadeHorizontalAnimationWidget(
                      delay: 0.5,
                      child: Container(
                          child: Text(
                        'Emergency',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ))),
                  Text(
                    state.getViewModel.getCurrentNumber == 0
                        ? ' '
                        : state.getViewModel.getCurrentNumber.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ]);

                grid = PhoneGridWidget(
                  callback: (item) =>
                      {gridButtonTapped(context, _bloc, item['d'], state)},
                  hintNeeded: true,
                  nextNumber: state.getViewModel.getNextNumber,
                );

                speechAnim = Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                            opacity: _hideHelper ? 0.0 : 1.0,
                            child: FadeVerticalAnimationWidget(
                                delay: 1.3,
                                child: PhoneSpeechWidget(
                                  text: '<- Hint: can you find that number?',
                                  icon: {
                                    9: Icons.filter_9,
                                    1: Icons.filter_1
                                  }[state.getViewModel.getNextNumber],
                                  color: Colors.redAccent,
                                  textColor: Colors.black87,
                                ),
                                key: UniqueKey()))));
                return Expanded(
                    child: Column(
                  children: <Widget>[
                    header,
                    grid,
                    gridBottom,
                    speechAnim,
                    SizedBox(height: 10)
                  ],
                ));
              } else if (state is PhoneCorrectState) {
                if (_prevBlocState != state) playCheer();
                header = Column(
                  children: [
                    FadeVerticalAnimationWidget(
                        delay: 1.3,
                        child: Container(
                            child: Text(
                          'Emergency',
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ))),
                    Showcase.withWidget(
                        key: _currentlyEnteredNumbersOverlayKey,
                        animationDuration: Duration(milliseconds: 1500),
                        height: 100,
                        width: 80,
                        container: Container(
                            color: Colors.transparent,
                            width: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                    child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                  )),
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      'Current phone number',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ))
                              ],
                            )),
                        child: Text(
                          state.getViewModel.getCurrentNumber.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )),
                  ],
                );

                grid = PhoneGridWidget(
                    callback: (item) =>
                        {gridButtonTapped(context, _bloc, item['d'], state)},
                    hintNeeded: false,
                    nextNumber: 0);

                speechAnim = Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                            opacity: _hideHelper ? 0.0 : 1.0,
                            child: FadeSoftAnimationWidget(
                                delay: 0.5,
                                child: PhoneSpeechWidget(
                                  text: 'Correct! Now tap the next digit!',
                                  icon: Icons.check_circle_outline,
                                  color: Colors.lightGreenAccent,
                                  textColor: Colors.black87,
                                ),
                                key: UniqueKey()))));

                return Expanded(
                    child: Column(
                  children: <Widget>[
                    header,
                    grid,
                    gridBottom,
                    _prevBlocState != state
                        ? ConfettiiWidget(playAll: false)
                        : Container(),
                    speechAnim,
                    SizedBox(height: 10)
                  ],
                ));
              } else if (state is PhoneFinishState) {
                if (_prevBlocState != state) playCheer();
                header = Column(
                  children: [
                    FadeVerticalAnimationWidget(
                        delay: 1.3,
                        child: Container(
                            child: Text(
                          'Emergency',
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ))),
                    Showcase.withWidget(
                        key: _currentlyEnteredNumbersOverlayKey,
                        animationDuration: Duration(milliseconds: 1500),
                        height: 100,
                        width: 80,
                        container: Container(
                            color: Colors.transparent,
                            width: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                    child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                  )),
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      'Current phone number',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ))
                              ],
                            )),
                        child: Text(
                          state.getViewModel.getCurrentNumber.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )),
                  ],
                );

                grid = PhoneGridWidget(
                    callback: (item) => {}, hintNeeded: false, nextNumber: 0);

                _prevBlocState = state;
                gridBottom = Center(
                    child: TouchAnimationWidget(
                  icon: Icons.phone,
                  iconColor: Colors.white,
                  startColor: Colors.white,
                  endColor: Colors.white,
                  iconSize: 40.0,
                  tapTextSize: 22.0,
                  callback: () => {phoneButtonTapped()},
                ));
                speechAnim = Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FadeSoftAnimationWidget(
                            delay: 1.5,
                            child: PhoneSpeechWidget(
                              text: 'Good job kid, now call the cops!',
                              icon: Icons.phone,
                              color: Colors.red,
                              textColor: Colors.black87,
                            ),
                            key: UniqueKey())));

                return Expanded(
                    child: Column(
                  children: <Widget>[
                    header,
                    grid,
                    gridBottom,
                    ConfettiiWidget(playAll: true),
                    speechAnim,
                    SizedBox(height: 10)
                  ],
                ));
              }
            }
            // default
            return Container();
          }),
        ],
      ),
    ));
  }

  emergencyTapped(BuildContext context, PhoneBloc bloc) {
    ShowCaseWidget.of(context)
        .startShowCase([_gridOverlayKey, _dogeOverlayKey]);
    EdgeAlert.show(context,
        icon: Icons.phone_locked,
        title: 'Time to call the cops kid',
        description: 'hope you are ready',
        backgroundColor: Colors.redAccent,
        gravity: EdgeAlert.TOP);

    setState(() {
      bloc.add(PhoneLoadedEvent());
    });
  }

  gridButtonTapped(
      BuildContext context, PhoneBloc bloc, int d, PhoneState state) {
    if (d == bloc.getRepo.getNextNum) {
      EdgeAlert.show(context,
          icon: Icons.check_circle,
          title: 'Correct digit tapped kid',
          description: 'nice job!',
          backgroundColor: Colors.lightGreenAccent,
          gravity: EdgeAlert.TOP);
      if (!_hidePressed) {
        setState(() {
          _hidePressed = true;
        });
        ShowCaseWidget.of(context)
            .startShowCase([_currentlyEnteredNumbersOverlayKey]);
      }
    } else {
      EdgeAlert.show(context,
          icon: Icons.cancel,
          title: 'Wrong digit tapped kid',
          description: 'Try it again!',
          backgroundColor: Colors.redAccent,
          gravity: EdgeAlert.TOP);
    }
    setState(() {
      _prevBlocState = state;
      bloc.add(PhoneInputEvent(d));
    });
  }

  hideButtonTapped(state) {
    setState(() {
      _prevBlocState = state;
      _hideHelper = !_hideHelper;
    });
  }

  phoneButtonTapped() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => CallingWidget()));
  }
}
