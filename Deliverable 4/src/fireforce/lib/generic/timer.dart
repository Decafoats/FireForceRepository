import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final double _timerSize;
  final Color _timerColor;

  TimerWidget({timerSize, timerColor})
      : _timerSize = timerSize,
        _timerColor = timerColor;

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  String _durationElapsed = "00:00:00";
  Stopwatch _clock = Stopwatch();

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Text(
      _durationElapsed,
      style: TextStyle(
          color: this.widget._timerColor, fontSize: this.widget._timerSize),
    );
  }

  void timerTickHandler() {
    if (mounted) {
      setState(() {
        _durationElapsed = _clock.elapsed.inHours.toString().padLeft(2, "0") +
            ':' +
            (_clock.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
            ':' +
            (_clock.elapsed.inSeconds % 60).toString().padLeft(2, "0");
      });
    }
  }

  void startTimeTicker() {
    Timer(Duration(seconds: 1), timerTickHandler);
  }

  void startTimer() {
    if (mounted) {
      setState(() {
        _clock.start();
        startTimeTicker();
      });
    }
  }
}
