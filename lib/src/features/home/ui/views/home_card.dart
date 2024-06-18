import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/percent_item.dart';
import 'package:sizer/sizer.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String? title1, title2;
  final num percent, total, percent2;
  final Widget? widget;
  final double? cHeight, cWidth;

  const HomeCard({
    super.key,
    required this.title,
    required this.percent,
    required this.total,
    required this.percent2,
    this.title1,
    this.title2,
    this.cHeight,
    this.cWidth,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
      width: cWidth ?? 18.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black,
            blurRadius: 5,
            offset: Offset(0, 0), // Shadow position
          ),
        ],
      ),
      child: widget ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(bottom: 1.h, left: 0.5.w, right: 0.5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      text: title,
                      fontSize: 4.sp,
                    ),
                    DefaultText(
                      text:
                          "${((percent / (total == 0 ? 1 : total)) * 100).toStringAsFixed(1)} %",
                      fontSize: 4.sp,
                    ),
                  ],
                ),
              ),
              PercentItem(
                title: title1 ?? "Active",
                cWidth: cWidth ?? 18.w,
                percent: percent,
                total: total,
                color: Colors.blueAccent,
              ),
              PercentItem(
                title: title2 ?? "Disabled",
                cWidth: cWidth ?? 18.w,
                percent: percent2,
                total: total,
                color: Colors.redAccent,
              ),
            ],
          ),
    );
  }
}
