import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class AnimatedLiquidLinearProgressIndicatorWidget extends StatefulWidget {
  final Color _backgroundColor;
  final Color _textColor;
  final Color _liquidColor;
  final Color _borderColor;
  final double _textSize;
  final Duration _duration;
  final Function _callback;

  AnimatedLiquidLinearProgressIndicatorWidget(
      {backgroundColor,
      textColor,
      liquidColor,
      borderColor,
      textSize,
      callback,
      duration})
      : _backgroundColor = backgroundColor,
        _textColor = textColor,
        _liquidColor = liquidColor,
        _borderColor = borderColor,
        _textSize = textSize,
        _callback = callback,
        _duration = duration;

  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidLinearProgressIndicatorState();
}

class _AnimatedLiquidLinearProgressIndicatorState
    extends State<AnimatedLiquidLinearProgressIndicatorWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget._duration,
    );

    _animationController.addStatusListener(widget._callback);
    _animationController.addListener(() => setState(() {}));
    //_animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    final percentage = _animationController.value * 100;
    return Center(
      child: Container(
        width: double.infinity,
        height: 75.0,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: LiquidLinearProgressIndicator(
          value: _animationController.value,
          backgroundColor: widget._backgroundColor,
          valueColor: AlwaysStoppedAnimation(widget._liquidColor),
          borderRadius: 12.0,
          borderWidth: 1.0,
          borderColor: widget._borderColor,
          center: Text(
            "${percentage.toStringAsFixed(0)}%",
            style: TextStyle(
              color: widget._textColor,
              fontSize: widget._textSize,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
