import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/views/comment_view.dart';
import 'package:jetboard/src/features/crew/cubit/crew_cubit.dart';
import 'package:jetboard/src/features/crew/ui/views/add_crew_view.dart';
import 'package:jetboard/src/features/crew/ui/views/crew_area.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:sizer/sizer.dart';

class CrewView extends StatefulWidget {
  final CrewCubit cubit;

  const CrewView({
    required this.cubit,
    super.key,
  });

  @override
  State<CrewView> createState() => _CrewViewState();
}

class _CrewViewState extends State<CrewView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          itemCount: widget.cubit.crew!.length,
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
                  flex: 2,
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
                        widget.cubit.crew![index].name ?? "",
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
                        'Phone',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.crew![index].phone ?? "",
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.crew![index].email ?? "",
                        style: TextStyle(
                          fontSize: 2.5.sp,
                          fontWeight: FontWeight.bold,
                        ),
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
                        'Rate',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.crew![index].rate.toString(),
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                  child: CircleAvatar(
                    backgroundColor: widget.cubit.crew![index].isActive == true
                        ? AppColors.green
                        : AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Switch(
                  value:
                      widget.cubit.crew![index].isActive == true ? true : false,
                  activeColor: AppColors.green,
                  activeTrackColor: AppColors.lightGreen,
                  inactiveThumbColor: AppColors.red,
                  inactiveTrackColor: AppColors.lightGrey,
                  splashRadius: 3.0,
                  onChanged: (value) {
                    widget.cubit.switched(widget.cubit.crew![index]);
                  },
                ),
                SizedBox(
                  width: 1.w,
                ),
                IconButton(
                  onPressed: () {
                    showDialog<void>(
                      context: NavigationService.context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return CrewArea(
                          crewId: widget.cubit.crew![index].id!,
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.area_chart,
                    color: AppColors.grey,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                AddCrewView(
                  cubit: widget.cubit,
                  title: "Update",
                  crew: widget.cubit.crew![index],
                ),
                SizedBox(
                  width: 1.w,
                ),
                CommentView(
                  comment: widget.cubit.crew![index].adminComment!,
                  onSave: (value) {
                    widget.cubit.userAdminComment(
                      userId: widget.cubit.crew![index].id!,
                      adminComment: value,
                      afterSuccess: () {
                        setState(() {
                          widget.cubit.crew![index].adminComment = value;
                        });
                        NavigationService.pop();
                      },
                    );
                  },
                ),
                SizedBox(
                  width: 1.w,
                ),
                IconButton(
                  onPressed: () {
                    widget.cubit.deleteCrew(
                      id: widget.cubit.crew![index].id!,
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.red,
                    size: 20,
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
