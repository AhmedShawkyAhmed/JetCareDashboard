import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class MonthItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color color;
  final Color textColor;

  const MonthItem({
    required this.title,
    required this.color,
    required this.textColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.3.w),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 4.h,
            width: 5.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2.sp),
            ),
            child: Center(
              child: DefaultText(
                onTap: onTap,
                text: title,
                textColor: textColor,
                fontSize: 2.5.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
