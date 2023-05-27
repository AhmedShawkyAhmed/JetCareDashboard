import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/info_cubit/info_cubit.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/endDrawer_info.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants_variables.dart';
import '../../widgets/default_app_button.dart';
import '../../widgets/default_text_field.dart';

class InfoDesktop extends StatefulWidget {
  const InfoDesktop({super.key});

  @override
  State<InfoDesktop> createState() => _InfoDesktopState();
}

class _InfoDesktopState extends State<InfoDesktop> {
  TextEditingController search = TextEditingController();
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubiti = InfoCubit.get(context);

    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      key: scaffoldkey,
      endDrawer: BlocBuilder<InfoCubit, InfoState>(
        builder: (context, state) {
          return EndDrawerWidgetInfo(
            index: currentIndex,
            isEdit: cubit.isedit,
            infoModel:
                cubiti.infoList.isEmpty ? null : cubiti.infoList[currentIndex],
          );
        },
      ),
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
            children: [
              Container(
                padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextField(
                      password: false,
                      width: 25.w,
                      height: 5.h,
                      fontSize: 4.sp,
                      color: AppColors.white,
                      bottom: 0.5.h,
                      hintText: 'Title',
                      spreadRadius: 2,
                      blurRadius: 2,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      haveShadow: true,
                      controller: search,
                      onChange: (value){
                        if(value == ""){
                          cubiti.getInfo();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          cubiti.getInfo(keyword: search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
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
                      fontSize: 5.sp,
                      title: "Add",
                      onTap: () {
                        cubit.isedit = false;
                        dropItemsInfo = 'select';
                        scaffoldkey.currentState!.openEndDrawer();
                      },
                    )
                  ],
                ),
              ),
              BlocBuilder<InfoCubit, InfoState>(
                builder: (context, state) {
                  if (InfoCubit.get(context).infoResponse?.infoModel == null) {
                    return SizedBox(
                      height: 79.h,
                      child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                  top: 2.h,
                                  left: 3.2.w,
                                  right: 2.5.w,
                                  bottom: 0.5.h,
                                ),
                                child: LoadingView(
                                  width: 90.w,
                                  height: 5.h,
                                ),
                              )),
                    );
                  } else if (InfoCubit.get(context)
                      .infoResponse!
                      .infoModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Information Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      itemCount: InfoCubit.get(context).listCount,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          top: 2.h,
                          left: 3.2.w,
                          right: 2.5.w,
                          bottom: 1.h,
                        ),
                        child: RowData(
                          rowHeight: 9.h,
                          data: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'TitleEn',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      InfoCubit.get(context)
                                          .infoList[index]
                                          .titleEn,
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
                                      'ContentEn',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      InfoCubit.get(context)
                                          .infoList[index]
                                          .contentEn,
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
                                      'TitleAr',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      InfoCubit.get(context)
                                          .infoList[index]
                                          .titleAr,
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
                                      'ContentAr',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      InfoCubit.get(context)
                                          .infoList[index]
                                          .contentAr,
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
                                      'Type',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      InfoCubit.get(context)
                                          .infoList[index]
                                          .type,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
                            IconButton(
                                onPressed: () {
                                  currentIndex = index;
                                  cubit.isedit = true;
                                  scaffoldkey.currentState!.openEndDrawer();
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColors.grey,
                                )),
                            SizedBox(
                              width: 2.w,
                            ),
                            IconButton(
                                onPressed: () {
                                  cubiti.deleteInfo(
                                      infoModel: cubiti.infoList[index]);
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
