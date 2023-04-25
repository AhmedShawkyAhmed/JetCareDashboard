import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

class CircularItem extends StatelessWidget {
  final num percent, count;
  final String title;
  final Color color;

  const CircularItem({
    required this.color,
    required this.percent,
    required this.count,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 4.w,
      lineWidth: 2.sp,
      percent: (percent / (count == 0?1:count)).toDouble(),
      animation: true,
      animateFromLastPercent: true,
      center: DefaultText(text: "${((percent / (count == 0?1:count)) * 100).toStringAsFixed(1)} %",),
      footer: DefaultText(text: title),
      progressColor: color,
    );
  }
}
