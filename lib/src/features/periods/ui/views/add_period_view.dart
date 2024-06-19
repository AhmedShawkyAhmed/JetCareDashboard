import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/periods/cubit/period_cubit.dart';
import 'package:jetboard/src/features/periods/data/requests/period_request.dart';
import 'package:sizer/sizer.dart';

TextEditingController fromController = TextEditingController();
TextEditingController toController = TextEditingController();

class AddPeriodView {
  AddPeriodView._();

  static void show({
    required PeriodCubit cubit,
  }) {
    showDialog(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const DefaultText(
                  text: "Add New Time Period",
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () async {
                    await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.fromSwatch(
                              primarySwatch: Colors.teal,
                              accentColor: Colors.teal,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child!,
                        );
                      },
                    ).then((value) {
                      if (value != null) {
                        toController.text = value.format(context);
                      } else {
                        printResponse("Time is not selected");
                      }
                      return null;
                    });
                  },
                  child: DefaultTextField(
                    controller: fromController,
                    height: 4.h,
                    width: 15.w,
                    haveShadow: true,
                    enabled: false,
                    spreadRadius: 2,
                    blurRadius: 2,
                    horizontalPadding: 0,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: "From",
                    password: false,
                    prefix: Icon(
                      Icons.watch_later,
                      color: AppColors.darkGrey.withOpacity(0.7),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () async {
                    await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.fromSwatch(
                              primarySwatch: Colors.teal,
                              accentColor: Colors.teal,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child!,
                        );
                      },
                    ).then((value) {
                      if (value != null) {
                        toController.text = value.format(context);
                      } else {
                        printResponse("Time is not selected");
                      }
                      return null;
                    });
                  },
                  child: DefaultTextField(
                    controller: toController,
                    height: 4.h,
                    width: 15.w,
                    haveShadow: true,
                    enabled: false,
                    spreadRadius: 2,
                    blurRadius: 2,
                    horizontalPadding: 0,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: "Choose Time",
                    password: false,
                    prefix: Icon(
                      Icons.watch_later,
                      color: AppColors.darkGrey.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Save",
              onTap: () {
                cubit.addPeriod(
                  request: PeriodRequest(
                    from: fromController.text,
                    to: toController.text,
                  ),
                );
                fromController.clear();
                toController.clear();
                NavigationService.pop();
              },
              width: 10.w,
              height: 4.h,
              fontSize: 3.sp,
              textColor: AppColors.white,
              buttonColor: AppColors.primary,
              isGradient: false,
              radius: 10,
            ),
            const SizedBox(
              width: 10,
            ),
            DefaultAppButton(
              title: "Cancel",
              onTap: () {
                NavigationService.pop();
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
        );
      },
    );
  }
}
