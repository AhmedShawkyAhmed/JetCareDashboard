import 'package:flutter/material.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/core/services/cache_service.dart';
import 'package:jetboard/src/core/routing/routes.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:sizer/sizer.dart';

class SplashMobile extends StatefulWidget {
  const SplashMobile({Key? key}) : super(key: key);

  @override
  State<SplashMobile> createState() => _SplashMobileState();
}

class _SplashMobileState extends State<SplashMobile> {
  @override
  void initState() {
    if (CacheService.get(key: "email") == null) {
      GlobalCubit.get(context).navigate(
        afterSuccess: () {
          Navigator.pushReplacementNamed(context,
            Routes.login.name,);
        },
      );
    } else {
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

