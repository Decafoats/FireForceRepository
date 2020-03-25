import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SpeechAnimatedWidget extends StatefulWidget {
  final String _text;
  final Color _textColor;
  final IconData _icon;
  final Color _iconColor;

  SpeechAnimatedWidget({text, textColor, icon, iconColor})
      : _text = text,
        _textColor = textColor,
        _icon = icon,
        _iconColor = iconColor;

  @override
  _SpeechAnimatedWidgetState createState() => _SpeechAnimatedWidgetState();
}

class _SpeechAnimatedWidgetState extends State<SpeechAnimatedWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new SpeechBubble(
            nipLocation: NipLocation.BOTTOM_LEFT,
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(widget._icon, color: widget._iconColor),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                ),
                Expanded(
                    child: TypewriterAnimatedTextKit(
                  isRepeatingAnimation: true,
                  totalRepeatCount: 1000,
                  speed: Duration(milliseconds: 100),
                  text: [widget._text],
                  textStyle:
                      TextStyle(fontSize: 18.0, color: widget._textColor),
                      key: UniqueKey(),
                ))
              ],
            )));
  }
}
