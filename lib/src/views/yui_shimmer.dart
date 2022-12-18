import 'package:flutter/material.dart';

// MEMO: - Shimmer が PWA でチラつく問題 一時回避代替
class YuiShimmer extends StatelessWidget {
  const YuiShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
