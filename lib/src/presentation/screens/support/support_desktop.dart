import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/support_cupit/support_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/endDrawer_support.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/default_text_field.dart';

class SupportDesktop extends StatelessWidget {
  TextEditingController search = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  SupportDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    var cubits = SupportCubit.get(context);
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      key: scaffoldkey,
      endDrawer: EndDrawerWidgetSupport(),
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
                  fontSize: 4.sp,
                  color: AppColors.white,
                  bottom: 0.5.h,
                  hintText: 'Name',
                  spreadRadius: 2,
                  blurRadius: 2,
                  shadowColor: AppColors.black.withOpacity(0.05),
                  haveShadow: true,
                  controller: search,
                  suffix: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      cubits.getSupport(keyword: search.text);
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
                      padding: EdgeInsets.only(top: 40.h,),
                      child: Center(
                        child: DefaultText(
                          text: "No Support Messages Yet !",
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
                                  cubits.supportList[index].id.toString(),
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
                                      cubits.supportList[index].name,
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
                                      cubits.supportList[index].contact,
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
                                      cubits.supportList[index].subject,
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
                                                  cubits.supportList[index]
                                                      .message,
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        cubits.supportList[index].message,
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
                                  cubits.deleteSupport(
                                      supportModel: cubits.supportList[index]);
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
