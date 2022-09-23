import 'dart:math';
import 'package:flutter/material.dart';

/// FlipController
class FlipController {
  // To be set from the state
  void Function(bool isFront)? _flip;
  bool Function()? _isFront;

  _printNullError() {
    debugPrint('Flip WARN: widget is not displayed or already disposed');
  }

  /// get front or back
  bool isFront() {
    if (_flip == null || _isFront == null) {
      _printNullError();
      return true;
    } else {
      return _isFront!.call();
    }
  }

  /// flip to other side
  flip() {
    if (_flip == null || _isFront == null) {
      _printNullError();
      return;
    } else {
      _flip!.call(!_isFront!.call());
    }
  }

  /// flip to front
  flipToFront() {
    if (_flip == null || _isFront == null) {
      _printNullError();
      return;
    } else {
      _flip!.call(true);
    }
  }

  /// flip to back
  flipToBack() {
    if (_flip == null || _isFront == null) {
      _printNullError();
      return;
    } else {
      _flip!.call(false);
    }
  }
}

/// FlipDirection
enum FlipDirection {
  horizontal,
  vertical,
}

/// Flip
class Flip extends StatefulWidget {
  /// controller
  final FlipController controller;

  /// duration fro a flip
  final int duration;

  /// start with front or back
  final bool startWithFront;

  /// horizontal or vertical
  final FlipDirection direction;

  /// front widget
  final Widget frontChild;

  /// back widget
  final Widget backChild;

  /// Flip
  const Flip({
    Key? key,
    required this.controller,
    this.duration = 1,
    this.startWithFront = true,
    this.direction = FlipDirection.horizontal,
    required this.frontChild,
    required this.backChild,
  }) : super(key: key);
  @override
  FlipState createState() => FlipState();
}

class FlipState extends State<Flip> with SingleTickerProviderStateMixin {
  bool _isFront = true;

  @override
  void initState() {
    _isFront = widget.startWithFront;
    super.initState();
    widget.controller._flip = flip;
    widget.controller._isFront = isFront;
  }

  flip(bool isFront) {
    setState(() {
      _isFront = isFront;
    });
  }

  bool isFront() {
    return _isFront;
  }

  @override
  void dispose() {
    widget.controller._flip = null; // 破棄される前に null へ戻す
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: widget.duration),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final rotate = Tween(begin: pi, end: 0.0).animate(animation);

        return AnimatedBuilder(
            animation: rotate,
            child: child,
            builder: (BuildContext context, Widget? child) {
              final angle = (ValueKey(_isFront) != widget.key)
                  ? min(rotate.value, pi / 2)
                  : rotate.value;
              // direction
              Matrix4 matrix4;
              switch (widget.direction) {
                case FlipDirection.horizontal:
                  matrix4 = Matrix4.rotationY(angle);
                  break;
                case FlipDirection.vertical:
                  matrix4 = Matrix4.rotationX(angle);
                  break;
              }
              return Transform(
                transform: matrix4,
                alignment: Alignment.center,
                child: child,
              );
            });
      },
      switchInCurve: Curves.linear,
      switchOutCurve: Curves.linear,
      child: _isFront
          ? Container(key: const ValueKey(true), child: widget.frontChild)
          : Container(key: const ValueKey(false), child: widget.backChild),
    );
  }
}
