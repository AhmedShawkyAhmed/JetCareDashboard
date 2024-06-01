import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../data/models/calender_model.dart';

class CalenderView extends StatelessWidget {
  final CalenderModel calenderModel;
  final VoidCallback onTap;

  const CalenderView({
    required this.calenderModel,
    required this.onTap,
    Key? key,
  }) : super(key: key);

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
                  text: calenderModel.dayName!,
                  fontWeight: FontWeight.w500,
                ),
                DefaultText(
                  text: calenderModel.day.toString(),
                  fontSize: 5.sp,
                ),
                DefaultText(
                  text: "Requests ${calenderModel.periods!.length.toString()}",
                  fontWeight: FontWeight.w500,
                ),
                DefaultText(
                  text: calenderModel.areas == null
                      ? ""
                      : calenderModel.areas!.isEmpty
                          ? ""
                          : calenderModel.areas?[0].nameAr ?? "",
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
