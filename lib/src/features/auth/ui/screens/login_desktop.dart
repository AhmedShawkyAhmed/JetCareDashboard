import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({super.key});

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  late AuthCubit cubit = BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: AppColors.white,
              height: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 65.h),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: Image.asset("assets/images/Group65W.png"),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 35.h,
                          child: Image.asset("assets/images/Rectangle73.png"),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 6.h),
                        height: 35.h,
                        child: Image.asset("assets/images/Rectangle74.png"),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 45.h,
                        child: Image.asset("assets/images/Frame6W.png"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.h, left: 12.w),
                    child: Row(
                      children: [
                        Container(
                          height: 25.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      1, 1), // changes position of shadow
                                )
                              ],
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 3.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DefaultTextField(
                                  password: false,
                                  bottom: 5.h,
                                  haveShadow: true,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  color: AppColors.white,
                                  shadowColor:
                                      AppColors.black.withOpacity(0.05),
                                  fontSize: 2.5.sp,
                                  controller: cubit.emailController,
                                  hintText: 'Email',
                                  height: 5.h,
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                DefaultTextField(
                                  validator: cubit.passwordController.text,
                                  haveShadow: true,
                                  password: cubit.password,
                                  spreadRadius: 2,
                                  bottom: 1.h,
                                  blurRadius: 2,
                                  color: AppColors.white,
                                  shadowColor:
                                      AppColors.black.withOpacity(0.05),
                                  fontSize: 2.5.sp,
                                  controller: cubit.passwordController,
                                  hintText: 'Password',
                                  height: 5.h,
                                  suffix: IconButton(
                                    onPressed: () {
                                      cubit.isPassword();
                                    },
                                    icon: Icon(
                                      cubit.password
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color:
                                          AppColors.darkGrey.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                DefaultAppButton(
                                  radius: 10,
                                  height: 4.h,
                                  width: 10.w,
                                  title: 'Sign In',
                                  onTap: () {
                                    cubit.login();
                                  },
                                  fontSize: 3.sp,
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
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.only(
                            right: 15.w,
                            bottom: 2.h,
                            top: 5.h,
                          ),
                          height: 30.h,
                          child: Image.asset("assets/images/logo.png"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
