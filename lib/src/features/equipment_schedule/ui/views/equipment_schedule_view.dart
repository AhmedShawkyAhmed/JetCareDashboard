import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/features/equipment_schedule/cubit/equipment_schedule_cubit.dart';
import 'package:jetboard/src/features/equipment_schedule/ui/views/return_equipment_view.dart';
import 'package:sizer/sizer.dart';

class EquipmentScheduleView extends StatefulWidget {
  final EquipmentScheduleCubit cubit;

  const EquipmentScheduleView({
    required this.cubit,
    super.key,
  });

  @override
  State<EquipmentScheduleView> createState() => _EquipmentScheduleViewState();
}

class _EquipmentScheduleViewState extends State<EquipmentScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          itemCount: widget.cubit.schedules!.length,
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
                        'Code',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.schedules![index].equipment!.code ?? "",
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
                        'Name',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.schedules![index].equipment!.name ?? "",
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
                        'Crew',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.schedules![index].crew!.name ?? "",
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
                        'Date & Time',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.schedules![index].date ?? "",
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
                        'Return Date & Time',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      ReturnEquipmentView(
                        cubit: widget.cubit,
                        schedule: widget.cubit.schedules![index],
                      ),
                    ],
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
