import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/periods/cubit/period_cubit.dart';
import 'package:jetboard/src/features/periods/data/models/period_model.dart';
import 'package:jetboard/src/features/periods/data/requests/period_request.dart';
import 'package:sizer/sizer.dart';

class AddPeriodView extends StatefulWidget {
  final String title;
  final PeriodCubit cubit;
  final PeriodModel? period;

  const AddPeriodView({
    required this.title,
    required this.cubit,
    this.period,
    super.key,
  });

  @override
  State<AddPeriodView> createState() => _AddPeriodViewState();
}

class _AddPeriodViewState extends State<AddPeriodView> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  @override
  void initState() {
    if (widget.period != null) {
      fromController.text = widget.period!.from ?? "";
      toController.text = widget.period!.to ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    fromController.clear();
    toController.clear();
    super.dispose();
  }

  void _show() {
    showDialog(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                DefaultText(
                  text: "${widget.title} Time Period",
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
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
                    );
                    if (pickedTime != null) {
                      printResponse(pickedTime);
                      setState(() {
                        fromController.text = pickedTime.format(context);
                      });
                    } else {
                      printResponse("Time is not selected");
                    }
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
                    TimeOfDay? pickedTime = await showTimePicker(
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
                    );
                    if (pickedTime != null) {
                      setState(() {
                        toController.text = pickedTime.format(context);
                      });
                    } else {
                      printResponse("Time is not selected");
                    }
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
              onTap: () async {
                if (widget.period == null) {
                  await widget.cubit.addPeriod(
                    request: PeriodRequest(
                      from: fromController.text,
                      to: toController.text,
                    ),
                  );
                } else {
                  await widget.cubit.updatePeriod(
                    request: PeriodRequest(
                      id: widget.period!.id,
                      from: fromController.text,
                      to: toController.text,
                    ),
                  );
                }
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

  @override
  Widget build(BuildContext context) {
    return DefaultAppButton(
      width: 8.w,
      height: 5.h,
      offset: const Offset(0, 0),
      spreadRadius: 2,
      blurRadius: 2,
      radius: 10,
      gradientColors: const [
        AppColors.green,
        AppColors.lightGreen,
      ],
      fontSize: 4.sp,
      haveShadow: false,
      title: widget.title,
      onTap: () {
        _show();
      },
    );
  }
}
