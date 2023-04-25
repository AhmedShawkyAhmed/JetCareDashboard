import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:sizer/sizer.dart';

class IndicatorView {
  static Future showIndicator(BuildContext context) async {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: 5.w,
            height: 5.w,
            child: const CircularProgressIndicator(
              color: AppColors.green,
            ),
          ),
        );
      },
    );
  }
}
