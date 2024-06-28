import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/crew/cubit/crew_cubit.dart';
import 'package:jetboard/src/features/equipment_schedule/cubit/equipment_schedule_cubit.dart';
import 'package:jetboard/src/features/equipments/cubit/equipment_cubit.dart';
import 'package:jetboard/src/features/equipments/data/models/equipment_model.dart';
import 'package:sizer/sizer.dart';

class AddScheduleView extends StatefulWidget {
  final EquipmentScheduleCubit cubit;
  final EquipmentCubit equipmentCubit;
  final CrewCubit crewCubit;

  const AddScheduleView({
    required this.cubit,
    required this.equipmentCubit,
    required this.crewCubit,
    super.key,
  });

  @override
  State<AddScheduleView> createState() => _AddScheduleViewState();
}

class _AddScheduleViewState extends State<AddScheduleView> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  int crewId = 0;
  int equipmentId = 0;
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

  Future<void> selectTime()async{
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
                  text: "Handover Equipment",
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  width: 15.w,
                  height: 4.h,
                  child: DefaultDropdown<EquipmentModel>(
                    hint: "Equipment",
                    showSearchBox: true,
                    itemAsString: (EquipmentModel? u) => u?.name ?? "",
                    items: widget.equipmentCubit.activeEquipments ?? [],
                    onChanged: (val) {
                      setState(() {
                        equipmentId = val!.id!;
                      });
                      printLog(equipmentId.toString());
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: 15.w,
                  height: 4.h,
                  child: DefaultDropdown<UserModel>(
                    hint: "Crew",
                    showSearchBox: true,
                    itemAsString: (UserModel? u) => u?.name ?? "",
                    items: widget.crewCubit.crew ?? [],
                    onChanged: (val) {
                      setState(() {
                        crewId = val!.id!;
                      });
                      printLog(crewId.toString());
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
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
                widget.cubit.assignEquipment(
                  equipmentId: equipmentId,
                  crewId: crewId,
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
    crewId = 0;
    equipmentId = 0;
    super.dispose();
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
      title: "Add",
      onTap: () {
        _show();
      },
    );
  }
}
