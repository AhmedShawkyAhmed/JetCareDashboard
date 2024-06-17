import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/features/splash/cubit/splash_cubit.dart';
import 'package:sizer/sizer.dart';

class SplashDesktop extends StatelessWidget {
  const SplashDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.mainColor,
          body: Center(
            child: Image.asset(
              "assets/images/translogow.png",
              width: 70.w,
            ),
          ),
        );
      },
    );
  }
}
