import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fireforce/generic/speech_animated.dart';

class PhoneSpeechWidget extends StatefulWidget {
  final String _text;
  final Color _textColor;
  final IconData _icon;
  final Color _iconColor;

  PhoneSpeechWidget({text, textColor, icon, color})
      : _text = text,
        _textColor = textColor,
        _icon = icon,
        _iconColor = color;

  @override
  State<StatefulWidget> createState() {
    return _PhoneSpeechState();
  }
}

class _PhoneSpeechState extends State<PhoneSpeechWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
            width: 90,
            height: 90,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/dog.png'))),
            )),
        Container(
            padding: EdgeInsets.only(left: 90),
            child: SpeechAnimatedWidget(
              text: widget._text,
              textColor: widget._textColor,
              icon: widget._icon,
              iconColor: widget._iconColor,
            ))
      ],
    );
  }
}
