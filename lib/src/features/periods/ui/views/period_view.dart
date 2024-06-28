import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/features/periods/cubit/period_cubit.dart';
import 'package:jetboard/src/features/periods/ui/views/add_period_view.dart';
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
                AddPeriodView(
                  title: "Update",
                  cubit: widget.cubit,
                  period: widget.cubit.periods![index],
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
