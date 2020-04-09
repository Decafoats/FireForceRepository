import 'package:flutter/cupertino.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ConfettiiWidget extends StatefulWidget {
  final bool _playAll;

  ConfettiiWidget({playAll}) : _playAll = playAll;

  @override
  _ConfettiState createState() => _ConfettiState();
}

class _ConfettiState extends State<ConfettiiWidget> {
  ConfettiController _controllerCenterRight;
  ConfettiController _controllerCenterLeft;
  ConfettiController _controllerTopCenter;
  ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    _controllerCenterRight = ConfettiController(duration: Duration(seconds: 1));
    _controllerCenterLeft = ConfettiController(duration: Duration(seconds: 1));
    _controllerTopCenter = ConfettiController(duration: Duration(seconds: 1));
    _controllerBottomCenter =
        ConfettiController(duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllerBottomCenter.play();
    if (widget._playAll) {
      _controllerCenterLeft.play();
      _controllerCenterRight.play();
      _controllerTopCenter.play();
    }

    return Stack(
      children: <Widget>[
        //CENTER RIGHT -- Emit left
        Align(
          alignment: Alignment.centerRight,
          child: ConfettiWidget(
            confettiController: _controllerCenterRight,
            blastDirection: pi,
            // radial value - LEFT
            emissionFrequency: 0.05,
            numberOfParticles: 10,
            shouldLoop: false,
            colors: [
              Colors.green,
              Colors.blue,
              Colors.pink
            ], // manually specify the colors to be used
          ),
        ),
        //CENTER LEFT
        Align(
          alignment: Alignment.centerLeft,
          child: ConfettiWidget(
            confettiController: _controllerCenterLeft,
            blastDirection: 0,
            // radial value - RIGHT
            emissionFrequency: 0.6,
            minimumSize: const Size(10, 10),
            // set the minimum potential size for the confetti (width, height)
            maximumSize: const Size(50, 50),
            // set the maximum potential size for the confetti (width, height)
            numberOfParticles: 1,
          ),
        ),
        //BOTTOM CENTER
        Align(
          alignment: Alignment.bottomCenter,
          child: ConfettiWidget(
            confettiController: _controllerBottomCenter,
            blastDirection: -pi / 2,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            maxBlastForce: 100,
            minBlastForce: 80,
          ),
        ),
      ],
    );
  }
}
