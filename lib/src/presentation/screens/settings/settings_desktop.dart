import 'package:flutter/material.dart';
import 'package:jetboard/src/business_logic/moderator_cubit/moderator_cubit.dart';
import 'package:jetboard/src/core/services/cache_service.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/views/moderator_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/default_app_button.dart';

class SettingsDesktop extends StatefulWidget {
  const SettingsDesktop({super.key});

  @override
  State<SettingsDesktop> createState() => _SettingsDesktopState();
}

class _SettingsDesktopState extends State<SettingsDesktop> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: Container(
        height: 100.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Wrap(
            spacing: 1.w,
            runSpacing: 2.h,
            children: [
              GestureDetector(
                child: RowData(
                  rowHeight: 12.h,
                  rowWidth: 10.w,
                  data: [
                    DefaultText(text: "Profile", fontSize: 4.sp),
                  ],
                ),
              ),
              GestureDetector(
                child: RowData(
                  rowHeight: 12.h,
                  rowWidth: 10.w,
                  data: [
                    DefaultText(text: "Password", fontSize: 4.sp),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppColors.white,
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              const DefaultText(
                                text: "Change Notification Status",
                                align: TextAlign.center,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              // todo notifications
                              DefaultAppButton(
                                title: "Disable",
                                // CacheHelper.getDataFromSharedPreference(
                                //           key: SharedPreferenceKeys.fcm) ==
                                //       "empty"
                                //   ? "Active"
                                //   : "Disable",
                                onTap: () {
                                  // if (CacheHelper.getDataFromSharedPreference(
                                  //         key: SharedPreferenceKeys.fcm) ==
                                  //     "empty") {
                                  // AuthCubit.get(context).updateFCM(
                                  //     id: CacheHelper
                                  //         .getDataFromSharedPreference(
                                  //             key: "id"),
                                  //     fcm: pushToken.toString());
                                  // CacheHelper.saveDataSharedPreference(
                                  //     key: SharedPreferenceKeys.fcm,
                                  //     value: pushToken.toString());
                                  // } else {
                                  // CacheHelper.saveDataSharedPreference(
                                  //     key: SharedPreferenceKeys.fcm,
                                  //     value: "empty");
                                  // }
                                  DefaultToast.showMyToast(
                                      "Notification Settings Updated Successfully");
                                  Navigator.pop(context);
                                },
                                width: 10.w,
                                height: 4.h,
                                fontSize: 3.sp,
                                textColor: AppColors.white,
                                buttonColor: AppColors.red,
                                // CacheHelper.getDataFromSharedPreference(
                                //             key:
                                //                 SharedPreferenceKeys.fcm) ==
                                //         "empty"
                                //     ? AppColors.pc
                                //     : AppColors.red,
                                isGradient: false,
                                radius: 10,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              DefaultAppButton(
                                title: "Cancel",
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                width: 10.w,
                                height: 4.h,
                                fontSize: 3.sp,
                                textColor: AppColors.mainColor,
                                buttonColor: AppColors.lightGrey,
                                isGradient: false,
                                radius: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: RowData(
                  rowHeight: 12.h,
                  rowWidth: 10.w,
                  data: [
                    DefaultText(text: "Notifications", fontSize: 4.sp),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  ModeratorCubit.get(context).getSettings(
                    moderatorId:
                    CacheService.get(key: "id"),
                    afterSuccess: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ModeratorView(
                            crewId: CacheService.get(
                                key: "id"),
                            isMine: true,
                          );
                        },
                      );
                    },
                  );
                },
                child: RowData(
                  rowHeight: 12.h,
                  rowWidth: 10.w,
                  data: [
                    DefaultText(text: "Permissions", fontSize: 4.sp),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
