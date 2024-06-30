import 'package:flutter/material.dart';
import 'package:jetboard/src/features/notifications/cubit/notifications_cubit.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:sizer/sizer.dart';

class NotificationsView extends StatefulWidget {
  final NotificationsCubit cubit;

  const NotificationsView({
    required this.cubit,
    super.key,
  });

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.h,
      child: ListView.builder(
        itemCount: widget.cubit.notifications!.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            top: 2.h,
            left: 3.2.w,
            right: 43,
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
                      'Title',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.notifications![index].title!,
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
                      'Message',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.notifications![index].message!,
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
                      'Created At',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.notifications![index].createdAt!
                          .toString()
                          .substring(0, 10),
                      style: TextStyle(fontSize: 3.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
