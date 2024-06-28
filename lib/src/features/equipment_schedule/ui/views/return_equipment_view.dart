import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/equipment_schedule/cubit/equipment_schedule_cubit.dart';
import 'package:jetboard/src/features/equipment_schedule/data/models/equipment_schedule_model.dart';
import 'package:sizer/sizer.dart';

class ReturnEquipmentView extends StatefulWidget {
  final EquipmentScheduleCubit cubit;
  final EquipmentScheduleModel schedule;

  const ReturnEquipmentView({
    required this.cubit,
    required this.schedule,
    super.key,
  });

  @override
  State<ReturnEquipmentView> createState() => _ReturnEquipmentViewState();
}

class _ReturnEquipmentViewState extends State<ReturnEquipmentView> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  DateTime now = DateTime.now();

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: NavigationService.context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime(now.year, now.month, now.day + 1),
      firstDate: DateTime(now.year, now.month, now.day + 1),
      lastDate: DateTime(2050),
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
    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd', 'en_US').format(picked);
    }
  }

  Future<void> selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: NavigationService.context,
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
        timeController.text = pickedTime.format(NavigationService.context);
      });
    } else {
      printResponse("Time is not selected");
    }
  }

  void _show() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const DefaultText(
                  text: "Return Equipment",
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: 3.h,
                ),
                GestureDetector(
                  onTap: () {
                    selectDate();
                  },
                  child: DefaultTextField(
                    controller: dateController,
                    height: 4.h,
                    width: 15.w,
                    haveShadow: true,
                    enabled: false,
                    spreadRadius: 2,
                    blurRadius: 2,
                    horizontalPadding: 0,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: "Choose Date",
                    password: false,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () async {
                    selectTime();
                  },
                  child: DefaultTextField(
                    controller: timeController,
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
                widget.cubit.returnEquipment(
                  id: widget.schedule.id!,
                  date: dateController.text,
                  time: timeController.text,
                );
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
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.schedule.returned == null
        ? IconButton(
            onPressed: () async {
              _show();
            },
            icon: const Icon(
              Icons.edit,
              color: AppColors.grey,
            ),
          )
        : Text(
            widget.schedule.returned.toString(),
            style: TextStyle(fontSize: 3.sp),
          );
  }
}
