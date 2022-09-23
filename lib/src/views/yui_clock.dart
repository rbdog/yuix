import 'dart:math';
import 'package:flutter/material.dart';

const a90 = pi / 2.0;
const d0 = a90 * 0;
const d90 = a90 * 1;
const d180 = a90 * 2;
const d270 = a90 * 3;
const d360 = a90 * 4;

class YuiClock extends StatefulWidget {
  final double size;
  final Widget clockBase;
  final Widget clockHand;
  const YuiClock({
    required this.clockBase,
    required this.clockHand,
    this.size = 80,
    Key? key,
  }) : super(key: key);

  @override
  YuiClockState createState() => YuiClockState();
}

class YuiClockState extends State<YuiClock>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _controller.addListener(() {
      setState(() {});
    });

    const w = 0.25;

    // パスワードフォームのアニメーション定義
    final myAnimatable = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: d0,
          end: d90,
        ).chain(CurveTween(curve: Curves.bounceOut)),
        weight: w, // 4秒のアニメーションのうちの1秒
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: d90,
          end: d180,
        ).chain(CurveTween(curve: Curves.bounceOut)),
        weight: w, // 4秒のアニメーションのうちの1秒
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: d180,
          end: d270,
        ).chain(CurveTween(curve: Curves.bounceOut)),
        weight: w, // 4秒のアニメーションのうちの1秒
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: d270,
          end: d360,
        ).chain(CurveTween(curve: Curves.bounceOut)),
        weight: w, // 4秒のアニメーションのうちの1秒
      ),
    ]);

    _rotateAnimation = myAnimatable.animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clockHand = AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, child) => child!,
      child: Transform.rotate(
        angle: _rotateAnimation.value,
        child: widget.clockHand,
      ),
    );

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          widget.clockBase,
          clockHand,
        ],
      ),
    );
  }
}
