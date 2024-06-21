import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/features/notifications/cubit/notifications_cubit.dart';
import 'package:jetboard/src/features/notifications/ui/views/add_notification_view.dart';
import 'package:jetboard/src/features/notifications/ui/views/notifications_view.dart';
import 'package:sizer/sizer.dart';

class NotificationsDesktop extends StatefulWidget {
  const NotificationsDesktop({super.key});

  @override
  State<NotificationsDesktop> createState() => _NotificationsDesktopState();
}

class _NotificationsDesktopState extends State<NotificationsDesktop> {
  NotificationsCubit cubit = NotificationsCubit(instance());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getNotifications(),
      child: Scaffold(
        backgroundColor: AppColors.green,
        body: Container(
          height: 100.h,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 5.h,
                    left: 3.w,
                    right: 50,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      AddNotificationView(cubit: cubit),
                    ],
                  ),
                ),
                BlocBuilder<NotificationsCubit, NotificationsState>(
                  builder: (context, state) {
                    if (cubit.notifications == null) {
                      return SizedBox(
                        height: 79.h,
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              top: 0.5.h,
                              left: 2.8.w,
                              right: 37,
                            ),
                            child: LoadingView(
                              width: 90.w,
                              height: 5.h,
                            ),
                          ),
                        ),
                      );
                    } else if (cubit.notifications!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Center(
                          child: DefaultText(
                            text: "No Notification Found !",
                            fontSize: 5.sp,
                          ),
                        ),
                      );
                    }
                    return NotificationsView(cubit: cubit);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
