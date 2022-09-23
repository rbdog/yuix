import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Rotating extends StatefulWidget {
  final double interval;
  final double duration;
  final Widget child;
  final Widget? backchild;
  const Rotating({
    Key? key,
    required this.child,
    required this.interval,
    required this.duration,
    this.backchild,
  }) : super(key: key);
  @override
  RotatingState createState() => RotatingState();
}

class RotatingState extends State<Rotating>
    with SingleTickerProviderStateMixin {
  bool _isFront = true;
  Timer? _timer;
  Widget? reversed;
  @override
  void initState() {
    if (widget.backchild != null) {
      reversed = widget.backchild!;
    } else {
      reversed = reverse(widget.child);
    }
    super.initState();
    setState(() {
      _isFront = !_isFront;
    });
    _timer = Timer.periodic(
      Duration(milliseconds: (widget.interval * 1000).round()),
      (Timer timer) {
        setState(() {
          _isFront = !_isFront;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // 破棄される前に停止する
    super.dispose();
  }

  Widget reverse(Widget child) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(pi), // 좌우 반전
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: (widget.duration * 1000).round()),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final rotate = Tween(begin: pi, end: 0.0).animate(animation);

        return AnimatedBuilder(
            animation: rotate,
            child: child,
            builder: (BuildContext context, Widget? child) {
              final angle = (ValueKey(_isFront) != widget.key)
                  ? min(rotate.value, pi / 2)
                  : rotate.value;
              return Transform(
                transform: Matrix4.rotationY(angle),
                alignment: Alignment.center,
                child: child,
              );
            });
      },
      switchInCurve: Curves.linear,
      switchOutCurve: Curves.linear,
      child: _isFront
          ? Container(key: const ValueKey(true), child: widget.child)
          : Container(key: const ValueKey(false), child: reversed),
    );
  }
}
