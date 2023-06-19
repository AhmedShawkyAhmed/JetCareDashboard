import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/support_cupit/support_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/default_text_field.dart';

class SupportDesktop extends StatefulWidget {
  const SupportDesktop({super.key});

  @override
  State<SupportDesktop> createState() => _SupportDesktopState();
}

class _SupportDesktopState extends State<SupportDesktop> {
  TextEditingController search = TextEditingController();


  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      backgroundColor: AppColors.green,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50),
                child: DefaultTextField(
                  password: false,
                  width: 25.w,
                  height: 5.h,
                  fontSize: 3.sp,
                  color: AppColors.white,
                  bottom: 0.5.h,
                  hintText: 'Name',
                  spreadRadius: 2,
                  blurRadius: 2,
                  shadowColor: AppColors.black.withOpacity(0.05),
                  haveShadow: true,
                  controller: search,
                  onChange: (value){
                    if(value == ""){
                      SupportCubit.get(context).getSupport();
                    }
                  },
                  suffix: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      SupportCubit.get(context).getSupport(keyword: search.text);
                      printResponse(search.text);
                    },
                    color: AppColors.black,
                  ),
                ),
              ),
              BlocBuilder<SupportCubit, SupportState>(
                builder: (context, state) {
                  if (SupportCubit.get(context).supportResponse?.supportModel ==
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
                  } else if (SupportCubit.get(context)
                      .supportResponse!
                      .supportModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 40.h,
                      ),
                      child: Center(
                        child: DefaultText(
                          text: "No Support Messages Found !",
                          fontSize: 5.sp,
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      itemCount: SupportCubit.get(context).listCount,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                            top: 2.h, left: 3.2.w, right: 2.5.w, bottom: 1.h),
                        child: RowData(
                          rowHeight: 8.h,
                          data: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID',
                                  style: TextStyle(fontSize: 3.sp),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                  SupportCubit.get(context).supportList[index].id.toString(),
                                  style: TextStyle(fontSize: 3.sp),
                                ),
                              ],
                            ),
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
                                      SupportCubit.get(context).supportList[index].name!,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Contact',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      SupportCubit.get(context).supportList[index].contact!,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Subject',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      SupportCubit.get(context).supportList[index].subject!,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 1,
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
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('Message'),
                                                content: Text(
                                                  SupportCubit.get(context).supportList[index]
                                                      .message!,
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        SupportCubit.get(context).supportList[index].message!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              width: 1.w,
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Details'),
                                      content: SizedBox(
                                        width: 50.w,
                                        height: 35.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const DefaultText(
                                              text: "Name",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            DefaultText(
                                              text: SupportCubit.get(context)
                                                  .supportList[index].name
                                                  .toString(),
                                              maxLines: 1,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            const DefaultText(
                                              text: "Phone",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            DefaultText(
                                              text: SupportCubit.get(context)
                                                  .supportList[index].contact
                                                  .toString(),
                                              maxLines: 1,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            const DefaultText(
                                              text: "Subject",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            DefaultText(
                                              text: SupportCubit.get(context)
                                                  .supportList[index].subject
                                                  .toString(),
                                              maxLines: 1,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            const DefaultText(
                                              text: "Message",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            DefaultText(
                                              text: SupportCubit.get(context)
                                                  .supportList[index].message
                                                  .toString(),
                                              maxLines: 5,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.remove_red_eye),
                              color: AppColors.grey,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (SupportCubit.get(context).supportList[index].adminComment !=
                                      "") {
                                    commentController.text =
                                    SupportCubit.get(context).supportList[index].adminComment ?? "";
                                  }
                                });
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: AppColors.white,
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            DefaultTextField(
                                              width: 50.w,
                                              height: 20.h,
                                              hintText: "Write your Comment",
                                              textColor: AppColors.mainColor,
                                              maxLength: 10000,
                                              fontSize: 4.sp,
                                              validator: "",
                                              maxLine: 5,
                                              controller: commentController,
                                              password: false,
                                              haveShadow: false,
                                              color: AppColors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      actions: <Widget>[
                                        DefaultAppButton(
                                          title: "Save",
                                          onTap: () {
                                            SupportCubit.get(context)
                                                .corporateAdminComment(
                                              orderId:
                                              SupportCubit.get(context)
                                                      .supportList[index]
                                                      .id,
                                              comment: commentController.text,
                                              afterSuccess: () {
                                                setState(() {
                                                  SupportCubit.get(context)
                                                          .supportList[index]
                                                          .adminComment =
                                                      commentController.text;
                                                });
                                                commentController.clear();
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
                                        DefaultAppButton(
                                          title: "Cancel",
                                          onTap: () {
                                            commentController.clear();
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
                              icon: const Icon(Icons.comment),
                              color: AppColors.grey,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            IconButton(
                                onPressed: () {
                                  SupportCubit.get(context).deleteSupport(
                                      supportModel: SupportCubit.get(context).supportList[index]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.red,
                                )),
                            SizedBox(
                              width: 3.w,
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
