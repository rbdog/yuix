import 'dart:math';
import 'package:flutter/material.dart';
import 'package:yuix/src/views/yui_colors.dart';

class YuiSlider extends StatefulWidget {
  const YuiSlider({
    super.key,
    required this.track,
    required this.trackFill,
    this.trackHeight = 5,
    this.thumb = const ColoredCircle(),
    this.thumbWidth = 20,
    this.thumbHeight = 20,
    required this.tickCount,
    this.insetBottom = 30,
    this.insetHorizontal = 20,
    required this.tickBuilder,
    required this.labelBuilder,
    this.onValueUpdate,
    this.rounded = true,
    this.onRounded,
  });

  factory YuiSlider.tickLabels({
    required List<Widget> labels,
    double thumbSize = 20,
    Color thumbColor = bananaYellow,
    double trackThickness = 5,
    Color? trackColor,
    Color trackFillColor = bananaYellow,
    ValueChanged<double>? onValueUpdate,
    bool rounded = true,
    ValueChanged<int>? onRounded,
  }) {
    final nonNullTrackColor = trackColor ?? trackFillColor
      ..withOpacity(0.3);
    return YuiSlider(
      trackHeight: trackThickness,
      track: Container(color: nonNullTrackColor),
      trackFill: Container(
        color: trackFillColor,
      ),
      tickCount: labels.length,
      tickBuilder: (index, isReached) {
        return Container(
          width: 2,
          height: 10,
          color: isReached ? trackFillColor : nonNullTrackColor,
        );
      },
      labelBuilder: (index, isReached) {
        return labels[index];
      },
      thumb: ColoredCircle(color: thumbColor),
      thumbWidth: thumbSize,
      thumbHeight: thumbSize,
      onValueUpdate: onValueUpdate,
      rounded: rounded,
      onRounded: onRounded,
    );
  }

  final Widget track;
  final Widget trackFill;
  final double trackHeight;
  final Widget thumb;
  final double thumbWidth;
  final double thumbHeight;
  final int tickCount;
  final double insetBottom;
  final double insetHorizontal;
  final bool rounded;
  final ValueChanged<int>? onRounded;
  final ValueChanged<double>? onValueUpdate;
  final Widget Function(int index, bool isReached) tickBuilder;
  final Widget Function(int index, bool isReached) labelBuilder;

  @override
  YuiSliderState createState() {
    return YuiSliderState();
  }
}

class YuiSliderState extends State<YuiSlider> {
  Widget get axis => widget.track;
  Widget get axisFill => widget.trackFill;
  double get axisHeight => widget.trackHeight;
  Widget get thumb => widget.thumb;
  double get thumbWidth => widget.thumbWidth;
  double get thumbHeight => widget.thumbHeight;
  int get tickCount => widget.tickCount;
  double get insetBottom => widget.insetBottom;
  double get insetHorizontal => widget.insetHorizontal;
  bool get rounded => widget.rounded;
  final thumbOffset = ValueNotifier(.0);
  late double axisWidth;

  @override
  void initState() {
    super.initState();
    if (!rounded) {
      thumbOffset.addListener(callOnValueUpdate);
    }
  }

  @override
  void dispose() {
    if (!rounded) {
      thumbOffset.removeListener(callOnValueUpdate);
    }
    super.dispose();
  }

  void callOnValueUpdate() {
    final ratioValue = thumbOffset.value / axisWidth;
    widget.onValueUpdate?.call(ratioValue);
  }

  double tickInterval() {
    return axisWidth / (tickCount - 1);
  }

  double tickEdgeContainerWidth() {
    final doubleInset = (insetHorizontal * 2);
    final containerWidth = tickInterval();
    return min(doubleInset, containerWidth);
  }

  double gapWidth() {
    final doubleInset = (insetHorizontal * 2);
    final containerWidth = tickInterval();
    if (doubleInset >= containerWidth) {
      return 0;
    } else {
      return (containerWidth - doubleInset) / 2;
    }
  }

  double minInsetTop() {
    if (thumbHeight > axisHeight) {
      return (thumbHeight - axisHeight) / 2;
    } else {
      return (axisHeight - thumbHeight) / 2;
    }
  }

  double minOffset() {
    return insetHorizontal - (thumbWidth / 2);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (coontext, constraints) {
        axisWidth = constraints.maxWidth - (insetHorizontal * 2);
        return Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // inset top
                SizedBox(
                  height: minInsetTop(),
                ),

                // slider area
                Container(
                  width: axisWidth,
                  height: axisHeight,
                  alignment: Alignment.center,
                  child: axis,
                ),

                // tick containers
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    ...List<Widget>.generate(
                      tickCount + 2, // 4 spacers
                      (index) {
                        if (index == 1 || index == tickCount) {
                          // postFirst or preLast
                          return SizedBox(
                            width: gapWidth(),
                          );
                        }

                        late final double width;
                        if (index == 0 || index == tickCount + 1) {
                          // first or last
                          width = tickEdgeContainerWidth();
                        } else {
                          width = tickInterval();
                        }

                        late final int tickIndex;
                        if (index == 0) {
                          // first
                          tickIndex = 0;
                        } else if (index == tickCount + 1) {
                          // last
                          tickIndex = tickCount - 1;
                        } else {
                          tickIndex = index - 1;
                        }

                        return SizedBox(
                          width: width,
                          height: insetBottom,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // tick
                              AnimatedBuilder(
                                animation: thumbOffset,
                                builder: (context, child) {
                                  return widget.tickBuilder(
                                    tickIndex,
                                    thumbOffset.value >
                                        tickInterval() * tickIndex,
                                  );
                                },
                              ),
                              const Spacer(),
                              // label
                              widget.labelBuilder(
                                tickIndex,
                                thumbOffset.value > tickInterval() * tickIndex,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),

            AnimatedBuilder(
              animation: thumbOffset,
              builder: (context, child) {
                return Positioned(
                  top: minInsetTop(),
                  left: minOffset() + (thumbWidth / 2),
                  child: SizedBox(
                    width: thumbOffset.value,
                    height: axisHeight,
                    child: axisFill,
                  ),
                );
              },
            ),
            // thumb

            AnimatedBuilder(
              animation: thumbOffset,
              builder: (context, child) {
                return Positioned(
                  left: minOffset() + thumbOffset.value,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      final newOffset = thumbOffset.value + details.delta.dx;
                      if (0 <= newOffset && newOffset <= axisWidth) {
                        thumbOffset.value = newOffset;
                      }
                    },
                    onHorizontalDragEnd: (details) {
                      if (rounded) {
                        final int index =
                            (thumbOffset.value / tickInterval()).round();
                        final newOffset = tickInterval() * index;
                        thumbOffset.value = newOffset;
                        widget.onValueUpdate?.call(newOffset);
                        widget.onRounded?.call(index);
                      }
                    },
                    child: Container(
                      width: thumbWidth,
                      height: thumbHeight,
                      alignment: Alignment.center,
                      child: thumb,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class ColoredCircle extends StatelessWidget {
  const ColoredCircle({
    super.key,
    this.color = bananaYellow,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

void main() {
  final widget = YuiSlider.tickLabels(
    onRounded: (index) {
      debugPrint(index.toString());
    },
    labels: [
      Text('1'),
      Text('2'),
      Text('3'),
      Text('4'),
      Text('5'),
      Text('6'),
      Text('7'),
      Text('8'),
      Text('9'),
      Text('10'),
    ],
  );
  final app = MaterialApp(
    home: Scaffold(
      body: Center(
        child: widget,
      ),
    ),
  );
  runApp(app);
}
