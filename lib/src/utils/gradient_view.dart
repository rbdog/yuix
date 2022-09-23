import 'package:flutter/material.dart';

class GradientView extends StatelessWidget {
  final List<Color> colors;
  final Widget? child;
  const GradientView({required this.colors, Key? key, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          colors: colors,
        ),
      ),
      child: child,
    );
  }
}
