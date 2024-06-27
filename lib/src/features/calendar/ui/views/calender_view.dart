import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/features/calendar/data/models/calendar_model.dart';
import 'package:sizer/sizer.dart';

class CalenderView extends StatelessWidget {
  final CalendarModel calendarModel;
  final VoidCallback onTap;

  const CalenderView({
    required this.calendarModel,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(
                  text: calendarModel.dayName!,
                  fontWeight: FontWeight.w500,
                ),
                DefaultText(
                  text: calendarModel.day.toString(),
                  fontSize: 5.sp,
                ),
                DefaultText(
                  text: "Requests ${calendarModel.periods!.length.toString()}",
                  fontWeight: FontWeight.w500,
                ),
                DefaultText(
                  text: calendarModel.area == null
                      ? ""
                      : calendarModel.area!.isEmpty
                          ? ""
                          : calendarModel.area?[0].nameAr ?? "",
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 2.w,
                height: 2.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: AppColors.green,
                ),
                child: Icon(
                  Icons.edit,
                  color: AppColors.white,
                  size: 3.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
