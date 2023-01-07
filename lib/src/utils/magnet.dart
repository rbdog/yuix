import 'package:flutter/material.dart';

//
//  Top Wall
// +----------+
// |          |
// |  ↑ pull  |
// |  ■       |
// |  ↓ pull  |
// |          |
// +----------+
//  Bottom Wall
//

enum _Phase {
  /// child is stopped on the wall, user can start dragging
  stop,

  /// user is dragging
  dragging,

  /// soon will be animating
  releasedToTop,

  /// soon will be animating
  releasedToBottom,

  /// now animating, and will be stopped on the wall
  animating,
}

// virtical align values
const _top = -1.0;
const _bottom = 1.0;

///
/// each side behaves like a magnet
/// * now implemented only virtical behavior
///
///
class MagnetWalled extends StatefulWidget {
  const MagnetWalled({
    this.autoReset = true,
    this.initialAlign = _bottom,
    this.onHitTopWall,
    this.onHitBottomWall,
    required this.child,
    super.key,
  });

  /// called when the child hits the top wall
  final void Function()? onHitTopWall;

  /// called when the child hits the bottom wall
  final void Function()? onHitBottomWall;

  /// reset to initial align when hits a wall
  final bool autoReset;

  /// initial align of child
  /// -1: Top, +1: Bottom
  final double initialAlign;

  /// widget to controll
  final Widget child;

  @override
  State<MagnetWalled> createState() => _MagnetWalledState();
}

class _MagnetWalledState extends State<MagnetWalled> {
  /// controll Phase
  var _phase = _Phase.stop;

  /// Animation Duration
  var _duration = Duration.zero;

  /// child height
  var childHeight = 0.0;

  /// global Y pixel position of pointer down for drag
  var _dragStartY = 0.0;

  /// last stopped wall align Y
  late double _homeAlign;

  /// child align position
  late double _align;

  @override
  void initState() {
    super.initState();
    _align = widget.initialAlign;
    _homeAlign = widget.initialAlign;
  }

  void saveChildHeight(double newHeight) {
    if (childHeight != newHeight) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          setState(() {
            childHeight = newHeight;
          });
        },
      );
    }
  }

  void onDragStart(double startY) {
    setState(() {
      _phase = _Phase.dragging;
      _dragStartY = startY;
    });
  }

  void onDragUpdate(double newAlign) {
    setState(() {
      _align = newAlign;
    });
  }

  void onDragEnd(double speed) {
    if (_align == _top) {
      // end without any animation
      widget.onHitTopWall?.call();
      stopAnimation();
    } else if (_align == _bottom) {
      // end without any animation
      widget.onHitBottomWall?.call();
      stopAnimation();
    } else if (speed <= 0) {
      // setup animation to top
      setState(() {
        _phase = _Phase.releasedToTop;
        _duration = animationDuration(speed, _top);
      });
    } else if (speed > 0) {
      // setup animation to bottom
      setState(() {
        _phase = _Phase.releasedToBottom;
        _duration = animationDuration(speed, _bottom);
      });
    }
  }

  void startAnimationIfNeeded() {
    if (_phase == _Phase.releasedToTop) {
      setState(() {
        _phase = _Phase.animating;
        _align = _top;
      });
      return;
    }
    if (_phase == _Phase.releasedToBottom) {
      setState(() {
        _phase = _Phase.animating;
        _align = _bottom;
      });
      return;
    }
  }

  Duration animationDuration(double releasedSpeed, double endAlign) {
    const baseDistance = 1.0;
    const baseSpeed = 100;
    const baseDuration = 1000.0; // sec
    const minSpeed = 300;
    const maxSpeed = 2400;

    var duration = baseDuration;
    // the more fast, the more short animation
    final speed = (releasedSpeed.abs().clamp(minSpeed, maxSpeed));
    duration = duration * (baseSpeed / speed);
    // the more closer, the more short animation
    final distance = (endAlign - _align).abs();
    duration = duration * (distance / baseDistance);
    return Duration(milliseconds: duration.toInt());
  }

  void stopAnimation() {
    if (widget.autoReset) {
      setState(() {
        _phase = _Phase.stop;
        _duration = Duration.zero;
        _homeAlign = widget.initialAlign;
        _align = widget.initialAlign;
      });
    } else {
      setState(() {
        _phase = _Phase.stop;
        _duration = Duration.zero;
        _homeAlign = _align;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => startAnimationIfNeeded(),
    );

    // * get child height by using Stack
    final child = Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              saveChildHeight(constraints.maxHeight);
              return Container();
            },
          ),
        ),
      ],
    );

    final gestureDetector = GestureDetector(
      onVerticalDragStart: (details) {
        onDragStart(details.globalPosition.dy);
      },
      onVerticalDragUpdate: (details) {
        final maxDaggableLength = context.size!.height - childHeight;
        final draggedLength = details.globalPosition.dy - _dragStartY;
        final alignDiff =
            (draggedLength / maxDaggableLength) * (_bottom - _top);
        final newAlign = (_homeAlign + alignDiff).clamp(_top, _bottom);
        onDragUpdate(newAlign);
      },
      onVerticalDragEnd: (details) {
        final speed = details.velocity.pixelsPerSecond.dy;
        onDragEnd(speed);
      },
      child: child,
    );

    final animatedAlign = AnimatedAlign(
      alignment: Alignment(0, _align),
      duration: _duration,
      child: gestureDetector,
      onEnd: () {
        if (_phase != _Phase.animating) {
          return;
        }
        if (_align == _top) {
          widget.onHitTopWall?.call();
          stopAnimation();
          return;
        }
        if (_align == _bottom) {
          widget.onHitBottomWall?.call();
          stopAnimation();
          return;
        }
      },
    );

    return animatedAlign;
  }
}
