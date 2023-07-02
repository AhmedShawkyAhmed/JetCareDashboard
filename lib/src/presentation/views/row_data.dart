import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:sizer/sizer.dart';

class RowData extends StatelessWidget {
   RowData({super.key, 
    required this.data,
    this.rowHeight,
    this.rowWidth,
    this.margin,
  });

  List<Widget> data = [];
  double? rowHeight, rowWidth,margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: margin ?? 0.w),
      padding: EdgeInsets.only(left: 1.w,right: 1.w),
      width: rowWidth ?? 86.w,
      height: rowHeight ?? 5.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
           BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 0), // changes position of shadow
            ),
    ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: data,
      ),
    );
  }
}