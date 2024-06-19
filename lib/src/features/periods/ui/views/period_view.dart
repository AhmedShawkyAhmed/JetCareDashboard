import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/periods/cubit/period_cubit.dart';
import 'package:jetboard/src/features/periods/data/requests/period_request.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:sizer/sizer.dart';

class PeriodView extends StatefulWidget {
  final PeriodCubit cubit;

  const PeriodView({
    required this.cubit,
    super.key,
  });

  @override
  State<PeriodView> createState() => _PeriodViewState();
}

class _PeriodViewState extends State<PeriodView> {

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          itemCount: widget.cubit.periods!.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              top: 2.h,
              left: 3.2.w,
              right: 2.5.w,
              bottom: 1.h,
            ),
            child: RowData(
              rowHeight: 8.h,
              data: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'From',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.periods![index].from.toString(),
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'To',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.periods![index].to.toString(),
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                  child: CircleAvatar(
                    backgroundColor: widget.cubit.periods![index].isActive!
                        ? AppColors.green
                        : AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Switch(
                  value: widget.cubit.periods![index].isActive! ? true : false,
                  activeColor: AppColors.green,
                  activeTrackColor: AppColors.lightGreen,
                  inactiveThumbColor: AppColors.red,
                  inactiveTrackColor: AppColors.lightGrey,
                  splashRadius: 3.0,
                  onChanged: (value) {
                    widget.cubit.switched(widget.cubit.periods![index]);
                  },
                ),
                SizedBox(
                  width: 1.w,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      fromController.text = widget.cubit.periods![index].from ?? "";
                      toController.text = widget.cubit.periods![index].to ?? "";
                    });
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
                                  text: "Update Time Period",
                                  align: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                      builder: (BuildContext context,
                                          Widget? child) {
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
                                        fromController.text =
                                            pickedTime.format(context);
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
                                    shadowColor:
                                        AppColors.black.withOpacity(0.05),
                                    hintText: "From",
                                    password: false,
                                    prefix: Icon(
                                      Icons.watch_later,
                                      color:
                                          AppColors.darkGrey.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                      builder: (BuildContext context,
                                          Widget? child) {
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
                                        toController.text =
                                            pickedTime.format(context);
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
                                    shadowColor:
                                        AppColors.black.withOpacity(0.05),
                                    hintText: "Choose Time",
                                    password: false,
                                    prefix: Icon(
                                      Icons.watch_later,
                                      color:
                                          AppColors.darkGrey.withOpacity(0.7),
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
                                widget.cubit.updatePeriod(
                                  request: PeriodRequest(
                                    id: widget.cubit.periods![index].id,
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
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                IconButton(
                  onPressed: () {
                    widget.cubit.deletePeriod(
                      id: widget.cubit.periods![index].id!,
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
