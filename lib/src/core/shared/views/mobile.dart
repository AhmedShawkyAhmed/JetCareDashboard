import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(),
          SizedBox(
            width: 90.w,
            height: 35.h,
            child: Center(
              child: Image.asset("assets/images/laptop.png"),
            ),
          ),
          SizedBox(
            width: 90.w,
            height: 10.h,
            child:  DefaultText(
              text:
                  'JetCare Dashboard Experience is not optimized for Mobile Currently',
              fontSize: 8.sp,
              align: TextAlign.center,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
