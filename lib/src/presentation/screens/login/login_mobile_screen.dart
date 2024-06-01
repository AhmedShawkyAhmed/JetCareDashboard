import 'package:flutter/material.dart';
import 'package:jetboard/src/core/routing/routes.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class LoginMobileScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.shimmerMain,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 75.h),
                  child: Row(
                    children: [
                      SizedBox(
                          height: 23.h,
                          child: Image.asset("assets/images/Group65.png")),
                      const Spacer(),
                      SizedBox(
                          height: 15.h,
                          child: Image.asset("assets/images/Rectangle73.png")),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 3.h),
                        height: 18.h,
                        child: Image.asset("assets/images/Rectangle74.png")),
                    const Spacer(),
                    SizedBox(
                        height: 30.h,
                        child: Image.asset("assets/images/Frame6.png")),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h, left: 13.w),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 12.w),
                          height: 30.h,
                          child: Image.asset("assets/images/logo.png")),
                      Container(
                        height: 40.h,
                        width: 75.w,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DefaultTextField(
                                password: false,
                                haveShadow: true,
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: AppColors.white,
                                shadowColor: AppColors.black.withOpacity(0.05),
                                fontSize: 15.sp,
                                controller: email,
                                hintText: 'Email',
                                height: 7.h,
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              DefaultTextField(
                                password: true,
                                haveShadow: true,
                                color: AppColors.white,
                                shadowColor: AppColors.black.withOpacity(0.05),
                                spreadRadius: 2,
                                blurRadius: 2,
                                fontSize: 15.sp,
                                controller: password,
                                hintText: 'Password',
                                height: 7.h,
                                suffix: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color:
                                          AppColors.darkGrey.withOpacity(0.7),
                                    )),
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                              DefaultAppButton(
                                radius: 10,
                                height: 5.h,
                                width: 35.w,
                                title: 'Sign In',
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context,
                                    Routes.layout.name,);
                                },
                                fontSize: 15.sp,
                                textColor: AppColors.white,
                                gradientColors: const [
                                  AppColors.green,
                                  AppColors.lightGreen,
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
