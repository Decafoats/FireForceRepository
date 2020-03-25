import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedIcon extends AnimatedWidget {
  final IconData _icon;
  final double _iconSize;
  final double _textSize;

  AnimatedIcon({Key key, Animation<Color> animation, icon, iconSize, textSize})
      : _icon = icon,
        _iconSize = iconSize,
        _textSize = textSize,
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<Color> animation = listenable;
    return new Wrap(
      children: <Widget>[
        new Text("Tap",
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _textSize,
                color: animation.value)),
        new Icon(_icon, color: animation.value, size: _iconSize),
      ],
    );
  }
}

class TouchAnimationWidget extends StatefulWidget {
  final IconData _icon;
  final double _iconSize;
  final Color _iconColor;
  final Color _startColor;
  final Color _endColor;
  final double _tapTextSize;
  final Function _callback;

  TouchAnimationWidget(
      {icon, iconSize, iconColor, startColor, endColor, tapTextSize, callback})
      : _icon = icon,
        _iconSize = iconSize,
        _iconColor = iconColor,
        _startColor = startColor,
        _endColor = endColor,
        _tapTextSize = tapTextSize,
        _callback = callback;

  @override
  _TouchAnimationState createState() => _TouchAnimationState();
}

class _TouchAnimationState extends State<TouchAnimationWidget>
    with SingleTickerProviderStateMixin {
  Animation<Color> _animation;
  AnimationController _controller;
  bool _visible;

  initState() {
    _visible = true;

    _controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    final Animation curve =
        new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _animation = new ColorTween(
            begin: widget._startColor.withOpacity(0.0),
            end: widget._endColor.withOpacity(1.0))
        .animate(curve);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      setState(() {
        // the animation object’s value is the changed state
      });
    });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget optIcon;
    widget._icon == null
        ? optIcon = Container()
        : optIcon = Icon(widget._icon,
            size: widget._iconSize, color: widget._iconColor);

    return new Container(
        child: Column(
      children: <Widget>[
        GestureDetector(
            onTap: () {
              widget._callback();
            },
            child: optIcon),
        Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _visible,
            child: AnimatedIcon(
              animation: _animation,
              icon: Icon(
                Icons.touch_app,
                color: widget._iconColor,
              ).icon,
              textSize: widget._tapTextSize,
              iconSize: widget._iconSize,
            )),
      ],
    ));
  }

  void hide() {
    setState(() {
      _visible = false;
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
