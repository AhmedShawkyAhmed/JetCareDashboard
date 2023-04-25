import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

class PercentItem extends StatelessWidget {
  const PercentItem({
    required this.title,
    required this.percent,
    required this.total,
    required this.cWidth,
    required this.color,
    Key? key,
  }) : super(key: key);

  final String title;
  final num percent, total;
  final double cWidth;
  final Color color;

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
                width:5.w,
                child: DefaultText(
                  text: title,
                  fontSize: 3.sp,
                ),
              ),
              SizedBox(
                width:5.w,
                child: DefaultText(
                  text: "${((percent / (total == 0?1:total)) * 100).toStringAsFixed(1)} %",
                  fontSize: 3.sp,
                  align: TextAlign.center,
                ),
              ),
              SizedBox(
                width:5.w,
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
          percent: (percent / (total == 0?1:total)).toDouble(),
          progressColor: color,
          animation: true,
          animateFromLastPercent: true,
          barRadius: const Radius.circular(20),
        ),
      ],
    );
  }
}
