import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

class PercentItem extends StatelessWidget {
  final String title;
  final num percent, total;
  final double cWidth;
  final Color color;

  const PercentItem({
    required this.title,
    required this.percent,
    required this.total,
    required this.cWidth,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 0.5.h,
            left: 0.5.w,
            right: 0.5.w,
            top: 1.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 5.w,
                child: DefaultText(
                  text: title,
                  fontSize: 3.sp,
                ),
              ),
              SizedBox(
                width: 15.w,
                child: DefaultText(
                  text: "$percent / $total",
                  fontSize: 3.sp,
                  align: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        LinearPercentIndicator(
          width: cWidth,
          lineHeight: 1.5.h,
          percent: (percent / (total == 0 ? 1 : total)).toDouble(),
          progressColor: color,
          animation: true,
          animateFromLastPercent: true,
          barRadius: const Radius.circular(20),
        ),
      ],
    );
  }
}
