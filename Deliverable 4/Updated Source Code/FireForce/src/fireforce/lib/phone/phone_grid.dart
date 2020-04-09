import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:fireforce/generic/animations/touch_animation.dart';

class PhoneGridWidget extends StatefulWidget {
  final Function _gridItemTapCallback;
  final bool _hintNeeded;
  final int _nextNumber;

  PhoneGridWidget({callback, hintNeeded = false, nextNumber, Key key})
      : this._gridItemTapCallback = callback,
        this._hintNeeded = hintNeeded,
        this._nextNumber = nextNumber,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PhoneGridState();
  }
}

class _PhoneGridState extends State<PhoneGridWidget> {
  final GlobalKey _hintOverlayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Start showcase view after current widget frames are drawn.
    if (widget._hintNeeded) {
      Future.delayed(Duration(seconds: 1), () {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => ShowCaseWidget.of(context).startShowCase([_hintOverlayKey]));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        padding: const EdgeInsets.all(20.0),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        children: [
          {'n': '1', 'd': 1, 'alt': ' '},
          {'n': '2', 'd': 2, 'alt': 'ABC'},
          {'n': '3', 'd': 3, 'alt': 'DEF'},
          {'n': '4', 'd': 4, 'alt': 'GHI'},
          {'n': '5', 'd': 5, 'alt': 'JKL'},
          {'n': '6', 'd': 6, 'alt': 'MNO'},
          {'n': '7', 'd': 7, 'alt': 'PQRS'},
          {'n': '8', 'd': 8, 'alt': 'TUV'},
          {'n': '9', 'd': 9, 'alt': 'WXYZ'},
          {'n': '*', 'd': 100, 'alt': ' '},
          {'n': '0', 'd': 0, 'alt': '+'},
          {'n': '#', 'd': 100, 'alt': ' '},
        ]
            .map((item) => GestureDetector(
                onTap: widget._gridItemTapCallback == null
                    ? () => {}
                    : () => {widget._gridItemTapCallback(item)},
                child: Column(
                  children: <Widget>[
                    Card(
                        color: Colors.redAccent,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: getGridItem(item))),
                  ],
                )))
            .toList());
  }

  Widget getGridItem(item) {
    if (widget._hintNeeded && item['d'] == widget._nextNumber) {
      return Showcase.withWidget(
          key: _hintOverlayKey,
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
                        'Tap the next current number.',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16),
                      ))
                ],
              )),
          child: Wrap(
            children: [
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(item['n'],
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        )),
                  ),
                  Positioned(
                      top: 10,
                      left: 15,
                      child: TouchAnimationWidget(
                        icon: null,
                        iconSize: 32.0,
                        startColor: Colors.grey,
                        endColor: Colors.white,
                        tapTextSize: 22.0,
                      )),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Text(item['alt'],
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ));
    }
    return Wrap(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text(item['n'],
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
              )),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(item['alt'],
              style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }
}
