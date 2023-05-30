import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetboard/src/data/models/notification_model.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/endDrawer_notification.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class NotificationsDesktop extends StatefulWidget {
  const NotificationsDesktop({super.key});

  @override
  State<NotificationsDesktop> createState() => _NotificationsDesktopState();
}

class _NotificationsDesktopState extends State<NotificationsDesktop> {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      endDrawer: EndDrawerWidgetNotification(),
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
                padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    DefaultAppButton(
                      width: 8.w,
                      height: 5.h,
                      haveShadow: true,
                      offset: const Offset(0, 0),
                      spreadRadius: 2,
                      blurRadius: 2,
                      radius: 10,
                      gradientColors: const [
                        AppColors.green,
                        AppColors.lightgreen,
                      ],
                      fontSize: 4.sp,
                      title: "Create",
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppColors.white,
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    const DefaultText(
                                        text:
                                            "Send Notifications to All Users !!",align: TextAlign.center,),
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
                                    NotificationCubit.get(context).notifyAll(
                                      title: titleController.text,
                                      message: messageController.text,
                                      afterSuccess: () {
                                        setState(() {
                                          NotificationCubit.get(context)
                                              .notificationResponse!
                                              .notifications!
                                              .insert(
                                                0,
                                                NotificationModel(
                                                  title: titleController.text,
                                                  message:
                                                      messageController.text,
                                                  createdAt: DateTime.now()
                                                      .toString()
                                                      .substring(0, 19),
                                                ),
                                              );
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  width: 10.w,
                                  height: 4.h,
                                  fontSize: 3.sp,
                                  textColor: AppColors.white,
                                  buttonColor: AppColors.pc,
                                  isGradient: false,
                                  radius: 10,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DefaultAppButton(
                                  title: "Cancel",
                                  onTap: () {
                                    Navigator.pop(context);
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
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (NotificationCubit.get(context)
                          .notificationResponse
                          ?.notifications ==
                      null) {
                    return SizedBox(
                      height: 79.h,
                      child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                    top: 0.5.h, left: 2.8.w, right: 37),
                                child: LoadingView(
                                  width: 90.w,
                                  height: 5.h,
                                ),
                              )),
                    );
                  } else if (NotificationCubit.get(context)
                      .notificationResponse!
                      .notifications!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Notification Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 85.h,
                    child: ListView.builder(
                      itemCount: NotificationCubit.get(context)
                          .notificationResponse!
                          .notifications!
                          .length,
                      itemBuilder: (context, index) => Padding(
                        padding:
                            EdgeInsets.only(top: 2.h, left: 3.2.w, right: 43),
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
                                    NotificationCubit.get(context)
                                        .notificationResponse!
                                        .notifications![index]
                                        .title!,
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
                                    NotificationCubit.get(context)
                                        .notificationResponse!
                                        .notifications![index]
                                        .message!,
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
                                    'Date & Time',
                                    style: TextStyle(fontSize: 3.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    NotificationCubit.get(context)
                                        .notificationResponse!
                                        .notifications![index]
                                        .createdAt!,
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
