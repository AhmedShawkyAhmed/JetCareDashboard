import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/core/routing/routes.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:sizer/sizer.dart';

class DrawerListMobile extends StatelessWidget {
  List<String> titles = [
    "Home",
    "Users",
    "Packages",
    "Items",
    "Extras",
    "Orders",
    "Info",
    "Ads",
    "Notifications",
    "Support",
    //"Logout",
  ];
  List<Widget> icons = [
    const Icon(
      Icons.home,
      color: AppColors.white,
    ),
    const Icon(
      Icons.person,
      color: AppColors.white,
    ),
    const Icon(
      Icons.playlist_add_check_circle_outlined,
      color: AppColors.white,
    ),
    const Icon(
      Icons.list,
      color: AppColors.white,
    ),
    const Icon(
      Icons.checklist_outlined,
      color: AppColors.white,
    ),
    const Icon(
      Icons.badge_sharp,
      color: AppColors.white,
    ),
    const Icon(
      Icons.person,
      color: AppColors.white,
    ),
    const Icon(
      Icons.notification_add_rounded,
      color: AppColors.white,
    ),
    const Icon(
      Icons.notification_important_outlined,
      color: AppColors.white,
    ),
    const Icon(
      Icons.face_retouching_natural,
      color: AppColors.white,
    ),
    // Icon(
    //   Icons.logout_outlined,
    //   color: AppColors.white,
    // ),
  ];

  DrawerListMobile({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2.0,
        sigmaY: 2.0,
      ),
      child: Drawer(
        elevation: 0.0,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.green,
              border: Border.all(color: AppColors.green)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h, left: 1.w, bottom: 2.h),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/logoc.png',
                      height: 7.h,
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      'Welcome\nJetCare',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                      ),
                      decoration: BoxDecoration(
                          color: index == cubit.selectedIndex
                              ? AppColors.shimmerMain
                              : AppColors.transparent,
                          borderRadius: BorderRadius.circular(50)),
                      child: ListTile(
                        //selectedColor: AppColors.blackl,
                        selectedTileColor: AppColors.shimmerMain,
                        selected: index == cubit.selectedIndex,
                        horizontalTitleGap: 0.0,
                        onTap: () {

                        },
                        leading: icons[index],
                        title: Text(
                          titles[index],
                          style: TextStyle(
                              fontSize: 15.sp, color: AppColors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 1.h, left: 1.w),
                child: ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 15.sp, color: AppColors.white),
                  ),
                  horizontalTitleGap: 0.0,
                  leading: const Icon(
                    Icons.logout,
                    color: AppColors.white,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.login.name,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
