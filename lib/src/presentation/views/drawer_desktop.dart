import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/moderator_cubit/moderator_cubit.dart';
import 'package:jetboard/src/data/data_provider/local/cache_helper.dart';
import 'package:jetboard/src/presentation/router/app_router_names.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:sizer/sizer.dart';

class DrawerListDesktop extends StatefulWidget {
  const DrawerListDesktop({super.key});

  @override
  State<DrawerListDesktop> createState() => _DrawerListDesktopState();
}

class _DrawerListDesktopState extends State<DrawerListDesktop> {
  List<String> titles = [
    "Home",
    "Orders",
    "Corporates",
    "Clients",
    "Moderators",
    "Crews",
    "Category",
    "Offers",
    "Items",
    "Corporate Items",
    "Extras Items",
    "Ads",
    "Governorate",
    "Area",
    "Periods",
    "Support",
    "Notifications",
    "Info",
    "Logout",
  ];

  List<Widget> icons = [
    const Icon(
      Icons.home,
      color: AppColors.white,
    ),
    const Icon(
      Icons.badge_sharp,
      color: AppColors.white,
    ),
    const Icon(
      Icons.corporate_fare,
      color: AppColors.white,
    ),
    const Icon(
      Icons.person,
      color: AppColors.white,
    ),
    const Icon(
      Icons.manage_accounts,
      color: AppColors.white,
    ),
    const Icon(
      Icons.perm_contact_cal_sharp,
      color: AppColors.white,
    ),
    const Icon(
      Icons.category_outlined,
      color: AppColors.white,
    ),
    const Icon(
      Icons.local_offer_outlined,
      color: AppColors.white,
    ),
    const Icon(
      Icons.list,
      color: AppColors.white,
    ),
    const Icon(
      Icons.list_alt,
      color: AppColors.white,
    ),
    const Icon(
      Icons.add_chart_rounded,
      color: AppColors.white,
    ),
    const Icon(
      Icons.ads_click_outlined,
      color: AppColors.white,
    ),
    const Icon(
      Icons.map_outlined,
      color: AppColors.white,
    ),
    const Icon(
      Icons.area_chart_outlined,
      color: AppColors.white,
    ),
    const Icon(
      Icons.timer_outlined,
      color: AppColors.white,
    ),
    const Icon(
      Icons.support_agent,
      color: AppColors.white,
    ),
    const Icon(
      Icons.notification_important_outlined,
      color: AppColors.white,
    ),
    const Icon(
      Icons.info_outline,
      color: AppColors.white,
    ),
    const Icon(
      Icons.logout_outlined,
      color: AppColors.white,
    ),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2.0,
        sigmaY: 2.0,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.green, border: Border.all(color: AppColors.green)),
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
                        height: 6.h,
                        width: 6.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    'Welcome\nJetCare',
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
                      color:
                          index == 0 ? AppColors.blackl : AppColors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ListTile(
                      selectedTileColor: AppColors.blackl,
                      selected: false,
                      horizontalTitleGap: 0.0,
                      onTap: () {
                        setState(() {
                          index = 0;
                        });
                        cubit.changeIndex(0);
                      },
                      leading: icons[0],
                      title: Text(
                        titles[0],
                        style: TextStyle(
                          fontSize: 2.5.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  if (ModeratorCubit.get(context).accessResponse?.settings?.orders == 1 &&
                          CacheHelper.getDataFromSharedPreference(key: "role") == "moderator"
                      || CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 1
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                          cubit.changeIndex(1);
                        },
                        leading: icons[1],
                        title: Text(
                          titles[1],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.corporates ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 2
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 2;
                          });
                          cubit.changeIndex(2);
                        },
                        leading: icons[2],
                        title: Text(
                          titles[2],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.clients ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 3
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 3;
                          });
                          cubit.changeIndex(3);
                        },
                        leading: icons[3],
                        title: Text(
                          titles[3],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.moderators ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 4
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 4;
                          });
                          cubit.changeIndex(4);
                        },
                        leading: icons[4],
                        title: Text(
                          titles[4],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.crews ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 5
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 5;
                          });
                          cubit.changeIndex(5);
                        },
                        leading: icons[5],
                        title: Text(
                          titles[5],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.category ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 6
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 6;
                          });
                          cubit.changeIndex(6);
                        },
                        leading: icons[6],
                        title: Text(
                          titles[6],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.offers ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 7
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 7;
                          });
                          cubit.changeIndex(7);
                        },
                        leading: icons[7],
                        title: Text(
                          titles[7],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.items ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 8
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 8;
                          });
                          cubit.changeIndex(8);
                        },
                        leading: icons[8],
                        title: Text(
                          titles[8],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.corporateItems ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 9
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 9;
                          });
                          cubit.changeIndex(9);
                        },
                        leading: icons[9],
                        title: Text(
                          titles[9],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.extrasItems ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 10
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 10;
                          });
                          cubit.changeIndex(10);
                        },
                        leading: icons[10],
                        title: Text(
                          titles[10],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.ads ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 11
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 11;
                          });
                          cubit.changeIndex(11);
                        },
                        leading: icons[11],
                        title: Text(
                          titles[11],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.governorate ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 12
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 12;
                          });
                          cubit.changeIndex(12);
                        },
                        leading: icons[12],
                        title: Text(
                          titles[12],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.area ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 13
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 13;
                          });
                          cubit.changeIndex(13);
                        },
                        leading: icons[13],
                        title: Text(
                          titles[13],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.periods ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 14
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 14;
                          });
                          cubit.changeIndex(14);
                        },
                        leading: icons[14],
                        title: Text(
                          titles[14],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.support ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 15
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 15;
                          });
                          cubit.changeIndex(15);
                        },
                        leading: icons[15],
                        title: Text(
                          titles[15],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.notifications ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 16
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 16;
                          });
                          cubit.changeIndex(16);
                        },
                        leading: icons[16],
                        title: Text(
                          titles[16],
                          style: TextStyle(
                            fontSize: 2.5.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (ModeratorCubit.get(context)
                              .accessResponse
                              ?.settings
                              ?.info ==
                          1 &&
                      CacheHelper.getDataFromSharedPreference(key: "role") ==
                          "moderator"|| CacheHelper.getDataFromSharedPreference(key: "role") == "admin") ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == 17
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        selectedTileColor: AppColors.blackl,
                        selected: false,
                        horizontalTitleGap: 0.0,
                        onTap: () {
                          setState(() {
                            index = 17;
                          });
                          cubit.changeIndex(17);
                        },
                        leading: icons[17],
                        title: Text(
                          titles[17],
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
                      color: index == 18
                          ? AppColors.blackl
                          : AppColors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ListTile(
                      selectedTileColor: AppColors.blackl,
                      selected: false,
                      horizontalTitleGap: 0.0,
                      onTap: () {
                        CacheHelper.clearData();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouterNames.login,
                          (route) => false,
                        );
                      },
                      leading: icons[18],
                      title: Text(
                        titles[18],
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
