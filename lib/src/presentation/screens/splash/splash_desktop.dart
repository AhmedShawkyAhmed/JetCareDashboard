import 'package:flutter/material.dart';
import 'package:jetboard/main.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/moderator_cubit/moderator_cubit.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/services/cache_service.dart';
import 'package:jetboard/src/core/routing/routes.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:sizer/sizer.dart';

class SplashDesktop extends StatefulWidget {
  const SplashDesktop({super.key});

  @override
  State<SplashDesktop> createState() => _SplashDesktopState();
}

class _SplashDesktopState extends State<SplashDesktop> {
  @override
  void initState() {
    printLog(CacheService.get(key: "role").toString());
    if (CacheService.get(key: "email") == null) {
      GlobalCubit.get(context).navigate(
        afterSuccess: () {
          Navigator.pushReplacementNamed(context,
            Routes.login.name,);
        },
      );
    } else {
      if (CacheService.get(key: "role") == "admin") {
        GlobalCubit.get(context).getStatistics(
          afterSuccess: () {
            GlobalCubit.get(context).navigate(
              afterSuccess: () {
                Navigator.pushReplacementNamed(context,
                  Routes.layout.name,);
              },
            );
          },
        );
      } else {
        ModeratorCubit.get(context).getSettings(
          moderatorId: CacheService.get(key: "id"),
          afterSuccess: () {
            GlobalCubit.get(context).getStatistics(
              afterSuccess: () {
                GlobalCubit.get(context).navigate(
                  afterSuccess: () {
                    Navigator.pushReplacementNamed(
                        context,
                      Routes.layout.name,);
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
