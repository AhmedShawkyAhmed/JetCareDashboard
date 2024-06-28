import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/views/comment_view.dart';
import 'package:jetboard/src/features/moderators/cubit/moderators_cubit.dart';
import 'package:jetboard/src/features/moderators/ui/views/add_moderator_view.dart';
import 'package:jetboard/src/features/moderators/ui/views/moderator_access_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:sizer/sizer.dart';

class ModeratorView extends StatefulWidget {
  final ModeratorsCubit cubit;

  const ModeratorView({
    required this.cubit,
    super.key,
  });

  @override
  State<ModeratorView> createState() => _ModeratorViewState();
}

class _ModeratorViewState extends State<ModeratorView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          itemCount: widget.cubit.moderators!.length,
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
                        widget.cubit.moderators![index].name ?? "",
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
                        widget.cubit.moderators![index].phone ?? "",
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
                        widget.cubit.moderators![index].email ?? "",
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
                        widget.cubit.moderators![index].rate.toString(),
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                  child: CircleAvatar(
                    backgroundColor:
                        widget.cubit.moderators![index].isActive == true
                            ? AppColors.green
                            : AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Switch(
                  value: widget.cubit.moderators![index].isActive == true
                      ? true
                      : false,
                  activeColor: AppColors.green,
                  activeTrackColor: AppColors.lightGreen,
                  inactiveThumbColor: AppColors.red,
                  inactiveTrackColor: AppColors.lightGrey,
                  splashRadius: 3.0,
                  onChanged: (value) {
                    widget.cubit.switched(widget.cubit.moderators![index]);
                  },
                ),
                SizedBox(
                  width: 1.w,
                ),
                IconButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return ModeratorAccessView(
                          moderatorId: widget.cubit.moderators![index].id!,
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.desktop_access_disabled_outlined,
                    color: AppColors.grey,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                AddModeratorView(
                  title: "update",
                  cubit: widget.cubit,
                  moderator: widget.cubit.moderators![index],
                ),
                SizedBox(
                  width: 1.w,
                ),
                CommentView(
                  comment: widget.cubit.moderators![index].adminComment ?? "",
                  onSave: (value) {
                    widget.cubit.userAdminComment(
                      userId: widget.cubit.moderators![index].id!,
                      adminComment: value,
                      afterSuccess: () {
                        setState(() {
                          widget.cubit.moderators![index].adminComment = value;
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
                    widget.cubit
                        .deleteAccount(id: widget.cubit.moderators![index].id!);
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
