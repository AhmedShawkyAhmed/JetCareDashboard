import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/views/drawer_mobile.dart';
import 'package:sizer/sizer.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
    return Scaffold(
      key: scaffoldkey,
      drawer: DrawerListMobile(),
      body: Padding(
        padding:  EdgeInsets.only(top: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                scaffoldkey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: 4.w, right: 4.w, top: 2.h, bottom: 3.h),
                // height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.black.withOpacity(0.06),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.03),
                      blurRadius: 5,
                      offset: const Offset(4, 8), // Shadow position
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 12.w),
                  child: Wrap(
                    spacing: 10.w,
                    runSpacing: 5.h,
                    children: const [
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
