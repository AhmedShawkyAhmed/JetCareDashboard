import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/data/data_provider/local/cache_helper.dart';
import 'package:jetboard/src/presentation/router/app_router_names.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:sizer/sizer.dart';

class DrawerListDesktop extends StatelessWidget {
  List<String> titles = [
    "Home",
    "Orders",
    "Corporates",
    "Users",
    "Crews",
    "Category",
    "Offers",
    "Items",
    "Equipment",
    "Equipment Schedule",
    "Ads",
    "Governorate",
    "Area",
    //"calendar",
    "Periods",
    //"Spaces",
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
      Icons.perm_contact_cal_sharp,
      color: AppColors.white,
    ),
    const Icon(
      Icons.category,
      color: AppColors.white,
    ),
    const Icon(
      Icons.local_offer_rounded,
      color: AppColors.white,
    ),
    const Icon(
      Icons.list,
      color: AppColors.white,
    ),
    const Icon(
      Icons.trolley,
      color: AppColors.white,
    ),
    const Icon(
      Icons.schedule_outlined,
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
      Icons.area_chart,
      color: AppColors.white,
    ),
    // const Icon(
    //   Icons.calendar_month,
    //   color: AppColors.white,
    // ),
    const Icon(
      Icons.timer_rounded,
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

  DrawerListDesktop({super.key});

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
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                        color: index == cubit.selectedIndex
                            ? AppColors.blackl
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(50)),
                    child: ListTile(
                      selectedTileColor: AppColors.blackl,
                      selected: index == cubit.selectedIndex,
                      horizontalTitleGap: 0.0,
                      onTap: () {
                        if (titles[index] == "Logout") {
                          CacheHelper.clearData();
                          Navigator.pushNamedAndRemoveUntil(context, AppRouterNames.login, (route) => false,);
                        } else {
                          cubit.changeIndex(index);
                        }
                      },
                      leading: icons[index],
                      title: Text(
                        titles[index],
                        style:
                            TextStyle(fontSize: 3.sp, color: AppColors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Padding(
            //   padding:  EdgeInsets.only(bottom: 25.h,left: 1.w),
            //   child: ListTile(
            //     title: Text("Logout",style: TextStyle(fontSize: 3.sp,color: AppColors.white),),
            //     horizontalTitleGap: 0.0,
            //     leading: Icon(Icons.logout,color: AppColors.white,),
            //     onTap: () {
            //       Navigator.pushNamed(context, AppRouterNames.login);
            //       CacheHelper.clearData();
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
