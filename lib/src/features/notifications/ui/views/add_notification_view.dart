import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/features/notifications/cubit/notifications_cubit.dart';
import 'package:jetboard/src/features/notifications/data/requests/notification_request.dart';
import 'package:sizer/sizer.dart';

class AddNotificationView extends StatefulWidget {
  final NotificationsCubit cubit;

  const AddNotificationView({
    required this.cubit,
    super.key,
  });

  @override
  State<AddNotificationView> createState() => _AddNotificationViewState();
}

class _AddNotificationViewState extends State<AddNotificationView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

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
                  text: "Send Notifications to All Users !!",
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: 2.h,
                ),
                DefaultTextField(
                  controller: titleController,
                  hintText: "Notification Title",
                  height: 5.h,
                  password: false,
                  haveShadow: false,
                ),
                SizedBox(
                  height: 1.h,
                ),
                DefaultTextField(
                  controller: messageController,
                  hintText: "Notification Message",
                  height: 5.h,
                  password: false,
                  haveShadow: false,
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Send",
              onTap: () {
                widget.cubit.notifyAll(
                  request: NotificationRequest(
                    title: titleController.text,
                    message: messageController.text,
                  ),
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
      title: "Create",
      onTap: () {
        _show();
      },
    );
  }
}
