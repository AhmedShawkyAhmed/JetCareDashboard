import 'package:flutter/material.dart';
import 'package:jetboard/main.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/moderator_cubit/moderator_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/data/data_provider/local/cache_helper.dart';
import 'package:jetboard/src/presentation/router/app_router_names.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:sizer/sizer.dart';

class SplashDesktop extends StatefulWidget {
  const SplashDesktop({Key? key}) : super(key: key);

  @override
  State<SplashDesktop> createState() => _SplashDesktopState();
}

class _SplashDesktopState extends State<SplashDesktop> {
  @override
  void initState() {
    printLog(pushToken.toString());
    printLog(CacheHelper.getDataFromSharedPreference(key: "role").toString());
    if (CacheHelper.getDataFromSharedPreference(key: "email") == null) {
      GlobalCubit.get(context).navigate(
        afterSuccess: () {
          Navigator.pushReplacementNamed(context, AppRouterNames.login);
        },
      );
    } else {
      if (CacheHelper.getDataFromSharedPreference(key: "role") == "admin") {
        GlobalCubit.get(context).getStatistics(
          afterSuccess: () {
            GlobalCubit.get(context).navigate(
              afterSuccess: () {
                Navigator.pushReplacementNamed(context, AppRouterNames.layout);
              },
            );
          },
        );
      } else {
        ModeratorCubit.get(context).getSettings(
          moderatorId: CacheHelper.getDataFromSharedPreference(key: "id"),
          afterSuccess: () {
            GlobalCubit.get(context).getStatistics(
              afterSuccess: () {
                GlobalCubit.get(context).navigate(
                  afterSuccess: () {
                    Navigator.pushReplacementNamed(
                        context, AppRouterNames.layout);
                  },
                );
              },
            );
          },
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: Image.asset(
          "assets/images/translogow.png",
          width: 70.w,
        ),
      ),
    );
  }
}
