import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/globals.dart';
import 'package:jetboard/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetboard/src/features/layout/cubit/layout_cubit.dart';
import 'package:sizer/sizer.dart';

class DrawerListDesktop extends StatefulWidget {
  final LayoutCubit cubit;

  const DrawerListDesktop({required this.cubit, super.key});

  @override
  State<DrawerListDesktop> createState() => _DrawerListDesktopState();
}

class _DrawerListDesktopState extends State<DrawerListDesktop> {
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2.0,
        sigmaY: 2.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.green,
          border: Border.all(
            color: AppColors.green,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h, left: 1.w, bottom: 2.h),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      color: AppColors.white,
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 5.h,
                        width: 5.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    'Welcome to\nJetCare',
                    style: TextStyle(
                      fontSize: 3.sp,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 1.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? AppColors.shimmerMain
                          : AppColors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ListTile(
                      selectedTileColor: AppColors.shimmerMain,
                      selected: false,
                      horizontalTitleGap: 0.5.w,
                      onTap: () {
                        setState(() {
                          index = 0;
                        });
                        widget.cubit.changeIndex(0);
                      },
                      leading: widget.cubit.items[0].icon,
                      title: Text(
                        widget.cubit.items[0].title,
                        style: TextStyle(
                          fontSize: 2.5.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  if (Globals.tabAccessData.orders == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 1
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                          widget.cubit.changeIndex(1);
                        },
                        leading: widget.cubit.items[1].icon,
                        title: Text(
                          widget.cubit.items[1].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.corporates == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 2
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 2;
                          });
                          widget.cubit.changeIndex(2);
                        },
                        leading: widget.cubit.items[2].icon,
                        title: Text(
                          widget.cubit.items[2].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.clients == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 3
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 3;
                          });
                          widget.cubit.changeIndex(3);
                        },
                        leading: widget.cubit.items[3].icon,
                        title: Text(
                          widget.cubit.items[3].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.moderators == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 4
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 4;
                          });
                          widget.cubit.changeIndex(4);
                        },
                        leading: widget.cubit.items[4].icon,
                        title: Text(
                          widget.cubit.items[4].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.crews == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 5
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 5;
                          });
                          widget.cubit.changeIndex(5);
                        },
                        leading: widget.cubit.items[5].icon,
                        title: Text(
                          widget.cubit.items[5].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 1.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: index == 6
                          ? AppColors.shimmerMain
                          : AppColors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ListTile(
                      selectedTileColor: AppColors.shimmerMain,
                      selected: false,
                      horizontalTitleGap: 0.5.w,
                      onTap: () {
                        setState(() {
                          index = 6;
                        });
                        widget.cubit.changeIndex(6);
                      },
                      leading: widget.cubit.items[6].icon,
                      title: Text(
                        widget.cubit.items[6].title,
                        style: TextStyle(
                          fontSize: 2.5.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  if (Globals.tabAccessData.category == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 7
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 7;
                          });
                          widget.cubit.changeIndex(7);
                        },
                        leading: widget.cubit.items[7].icon,
                        title: Text(
                          widget.cubit.items[7].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.offers == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 8
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 8;
                          });
                          widget.cubit.changeIndex(8);
                        },
                        leading: widget.cubit.items[8].icon,
                        title: Text(
                          widget.cubit.items[8].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.items == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 9
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 9;
                          });
                          widget.cubit.changeIndex(9);
                        },
                        leading: widget.cubit.items[9].icon,
                        title: Text(
                          widget.cubit.items[9].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.corporateItems == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 10
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 10;
                          });
                          widget.cubit.changeIndex(10);
                        },
                        leading: widget.cubit.items[10].icon,
                        title: Text(
                          widget.cubit.items[10].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.extrasItems == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 11
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 11;
                          });
                          widget.cubit.changeIndex(11);
                        },
                        leading: widget.cubit.items[11].icon,
                        title: Text(
                          widget.cubit.items[11].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.extrasItems == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 12
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 12;
                          });
                          widget.cubit.changeIndex(12);
                        },
                        leading: widget.cubit.items[12].icon,
                        title: Text(
                          widget.cubit.items[12].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.extrasItems == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 13
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 13;
                          });
                          widget.cubit.changeIndex(13);
                        },
                        leading: widget.cubit.items[13].icon,
                        title: Text(
                          widget.cubit.items[13].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.ads == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 14
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 14;
                          });
                          widget.cubit.changeIndex(14);
                        },
                        leading: widget.cubit.items[14].icon,
                        title: Text(
                          widget.cubit.items[14].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.governorate == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 15
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 15;
                          });
                          widget.cubit.changeIndex(15);
                        },
                        leading: widget.cubit.items[15].icon,
                        title: Text(
                          widget.cubit.items[15].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.area == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 16
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 16;
                          });
                          widget.cubit.changeIndex(16);
                        },
                        leading: widget.cubit.items[16].icon,
                        title: Text(
                          widget.cubit.items[16].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.periods == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 17
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 17;
                          });
                          widget.cubit.changeIndex(17);
                        },
                        leading: widget.cubit.items[17].icon,
                        title: Text(
                          widget.cubit.items[17].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.support == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 18
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 18;
                          });
                          widget.cubit.changeIndex(18);
                        },
                        leading: widget.cubit.items[18].icon,
                        title: Text(
                          widget.cubit.items[18].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.notifications == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 19
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 19;
                          });
                          widget.cubit.changeIndex(19);
                        },
                        leading: widget.cubit.items[19].icon,
                        title: Text(
                          widget.cubit.items[19].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (Globals.tabAccessData.info == true) ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 20
                            ? AppColors.shimmerMain
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.shimmerMain,
                        selected: false,
                        horizontalTitleGap: 0.5.w,
                        onTap: () {
                          setState(() {
                            index = 20;
                          });
                          widget.cubit.changeIndex(20);
                        },
                        leading: widget.cubit.items[20].icon,
                        title: Text(
                          widget.cubit.items[20].title,
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  // Container(
                  //   margin: EdgeInsets.symmetric(
                  //     horizontal: 1.w,
                  //     vertical: 0.5.h,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: index == 21
                  //         ? AppColors.blackl
                  //         : AppColors.transparent,
                  //     borderRadius: BorderRadius.circular(50),
                  //   ),
                  //   child: ListTile(
                  //     selectedTileColor: AppColors.blackl,
                  //     selected: false,
                  //     horizontalTitleGap: 0.0,
                  //     onTap: () {
                  //       setState(() {
                  //         index = 21;
                  //       });
                  //       widget.cubit.changeIndex(21);
                  //     },
                  //     leading: widget.cubit.items[21].icon,
                  //     title: Text(
                  //       widget.cubit.items[21].title,
                  //       style: TextStyle(
                  //         fontSize: 2.5.sp,
                  //         color: AppColors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 1.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: index == 21
                          ? AppColors.shimmerMain
                          : AppColors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ListTile(
                      selectedTileColor: AppColors.shimmerMain,
                      selected: false,
                      horizontalTitleGap: 0.5.w,
                      onTap: () {
                        AuthCubit(instance()).logout();
                      },
                      leading: widget.cubit.items[21].icon,
                      title: Text(
                        widget.cubit.items[21].title,
                        style: TextStyle(
                          fontSize: 2.5.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
