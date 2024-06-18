import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:sizer/sizer.dart';

class IndicatorView {
  static Future showIndicator() async {
    showDialog<void>(
      barrierDismissible: false,
      context: NavigationService.context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: 5.w,
            height: 5.w,
            child: const CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }
}
