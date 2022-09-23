import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yui_kit/src/views/yui_colors.dart';

// MEMO: - Shimmer が PWA でチラつく問題 一時回避代替
class YuiShimmer extends StatelessWidget {
  const YuiShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: yuiWhite,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: SizedBox(
        width: 100,
        height: 50,
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: yuiLightGrey,
          size: 50,
        ),
      ),
    );
  }
}
