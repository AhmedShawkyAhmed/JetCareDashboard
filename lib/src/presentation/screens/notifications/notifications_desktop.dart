import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/endDrawer_notification.dart';
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
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppColors.white,
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    const DefaultText(
                                        text:
                                            "Select Users to Send Notifications to !!"),
                                    SizedBox(height: 2.h,),
                                    DefaultTextField(
                                      controller: titleController,
                                      hintText: "Notification Title",
                                      height: 5.h,
                                      password: false,
                                      haveShadow: false,
                                    ),
                                    SizedBox(height: 1.h,),
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
                                    Navigator.pop(context);
                                  },
                                  width: 10.w,
                                  height: 4.h,
                                  fontSize: 3.sp,
                                  textColor: AppColors.white,
                                  buttonColor: AppColors.pc,
                                  isGradient: false,
                                  radius: 10,
                                ),
                                SizedBox(
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
              SizedBox(
                height: 85.h,
                child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(top: 2.h, left: 3.2.w, right: 43),
                    child: RowData(
                      data: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              index.toString(),
                              style: TextStyle(fontSize: 3.sp),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Gold',
                              style: TextStyle(fontSize: 3.sp),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              '100',
                              style: TextStyle(fontSize: 3.sp),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
