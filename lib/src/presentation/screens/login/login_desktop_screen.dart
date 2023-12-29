import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/moderator_cubit/moderator_cubit.dart';
import 'package:jetboard/src/data/data_provider/local/cache_helper.dart';
import 'package:jetboard/src/data/network/requests/auth_request.dart';
import 'package:jetboard/src/presentation/router/app_router_names.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:jetboard/src/presentation/widgets/indicator_view.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class LoginDeskTopScreen extends StatefulWidget {
  const LoginDeskTopScreen({super.key});

  @override
  State<LoginDeskTopScreen> createState() => _LoginDeskTopScreenState();
}

class _LoginDeskTopScreenState extends State<LoginDeskTopScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String emailText = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
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
                                  controller: email,
                                  hintText: 'Email',
                                  height: 5.h,
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                DefaultTextField(
                                  validator: password.text,
                                  haveShadow: true,
                                  password: AuthCubit.get(context).pass,
                                  spreadRadius: 2,
                                  bottom: 1.h,
                                  blurRadius: 2,
                                  color: AppColors.white,
                                  shadowColor:
                                      AppColors.black.withOpacity(0.05),
                                  fontSize: 2.5.sp,
                                  controller: password,
                                  hintText: 'Password',
                                  height: 5.h,
                                  suffix: IconButton(
                                      onPressed: () {
                                        AuthCubit.get(context).isPassword();
                                      },
                                      icon: Icon(
                                        AuthCubit.get(context).pass
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            AppColors.darkGrey.withOpacity(0.7),
                                      )),
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
                                    if (email.text == "") {
                                      DefaultToast.showMyToast(
                                          'Please Enter Email Address');
                                    } else if (password.text == "") {
                                      DefaultToast.showMyToast(
                                          'Please Enter Password');
                                    } else {
                                      IndicatorView.showIndicator(context);
                                      AuthCubit.get(context).login(
                                        authRequest: AuthRequest(
                                          email: email.text,
                                          password: password.text,
                                        ),
                                        admin: () {
                                          GlobalCubit.get(context)
                                              .getStatistics(
                                            afterSuccess: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                AppRouterNames.layout,
                                                (route) => false,
                                              );
                                            },
                                          );
                                        },
                                        moderator: () {
                                          ModeratorCubit.get(context)
                                              .getSettings(
                                            moderatorId: CacheHelper
                                                .getDataFromSharedPreference(
                                                    key: "id"),
                                            afterSuccess: () {
                                              GlobalCubit.get(context)
                                                  .getStatistics(
                                                afterSuccess: () {
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                    context,
                                                    AppRouterNames.layout,
                                                    (route) => false,
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                        afterFail: () {
                                          Navigator.pop(context);
                                          DefaultToast.showMyToast(
                                              "No Account Found !");
                                        },
                                      );
                                    }
                                  },
                                  fontSize: 3.sp,
                                  textColor: AppColors.white,
                                  gradientColors: const [
                                    AppColors.green,
                                    AppColors.lightgreen,
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
