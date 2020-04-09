import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeVerticalAnimationWidget extends StatefulWidget {
  final double _delay;
  final Widget _child;

  FadeVerticalAnimationWidget({delay, child, Key key})
      : _delay = delay,
        _child = child,
        super(key: key);

  @override
  _FadeVerticalAnimationState createState() => _FadeVerticalAnimationState();
}

class _FadeVerticalAnimationState extends State<FadeVerticalAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: 30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * widget._delay).round()),
      duration: tween.duration,
      tween: tween,
      child: widget._child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}

class FadeHorizontalAnimationWidget extends StatefulWidget {
  final double _delay;
  final Widget _child;

  FadeHorizontalAnimationWidget({delay, child, Key key})
      : _delay = delay,
        _child = child,
        super(key: key);

  @override
  _FadeHorizontalAnimationState createState() => _FadeHorizontalAnimationState();
}

class _FadeHorizontalAnimationState
    extends State<FadeHorizontalAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateX").add(
          Duration(milliseconds: 500), Tween(begin: 30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * widget._delay).round()),
      duration: tween.duration,
      tween: tween,
      child: widget._child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateX"]), child: child),
      ),
    );
  }
}

class FadeSoftAnimationWidget extends StatefulWidget {
  final double _delay;
  final Widget _child;

  FadeSoftAnimationWidget({delay, child, Key key})
      : _delay = delay,
        _child = child,
        super(key: key);

  @override
  _FadeSoftAnimationState createState() => _FadeSoftAnimationState();
}

class _FadeSoftAnimationState extends State<FadeSoftAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateX").add(
          Duration(milliseconds: 500), Tween(begin: 0.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * widget._delay).round()),
      duration: tween.duration,
      tween: tween,
      child: widget._child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateX"]), child: child),
      ),
    );
  }
}
