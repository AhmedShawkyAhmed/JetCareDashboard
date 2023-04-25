import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/area_cubit/area_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/data/network/requests/area_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/endDrawer_area.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class AreaDesktop extends StatefulWidget {
  const AreaDesktop({super.key});

  @override
  State<AreaDesktop> createState() => _AreaDesktopState();
}

class _AreaDesktopState extends State<AreaDesktop> {
  TextEditingController search = TextEditingController();
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  String dropdownvalue = 'Item 1';

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubitA = AreaCubit.get(context);

    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      key: scaffoldkey,
      endDrawer: BlocBuilder<AreaCubit, AreaState>(
        builder: (context, state) {
          return EndDrawerWidgetArea(
            index: currentIndex,
            isEdit: cubit.isedit,
            areaModel:
                cubitA.areaList.isEmpty ? null : cubitA.areaList[currentIndex],
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
                      hintText: 'Name',
                      spreadRadius: 2,
                      blurRadius: 2,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      haveShadow: true,
                      controller: search,
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          cubitA.getAllAreas(keyword: search.text);
                          printResponse(search.text);
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
              BlocBuilder<AreaCubit, AreaState>(
                builder: (context, state) {
                  if (AreaCubit.get(context).getAreaResponse?.areaModel == null) {
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
                  } else if (AreaCubit.get(context).getAreaResponse!.areaModel!.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Areas Yet !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      itemCount: AreaCubit.get(context).listCount,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          top: 2.h,
                          left: 3.2.w,
                          right: 2.5.w,
                          bottom: 1.h,
                        ),
                        child: RowData(
                          rowHeight: 7.h,
                          data: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'NameEn',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      AreaCubit.get(context)
                                          .areaList[index]
                                          .nameEn
                                          .toString(),
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
                                      'NameAr',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      AreaCubit.get(context)
                                          .areaList[index]
                                          .nameAr
                                          .toString(),
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
                                      'Price',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      AreaCubit.get(context)
                                          .areaList[index]
                                          .price
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 3.h,
                              child: CircleAvatar(
                                backgroundColor:
                                    cubitA.areaList[index].active == 1
                                        ? AppColors.green
                                        : AppColors.red,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Switch(
                                value: cubitA.areaList[index].active == 1
                                    ? true
                                    : false,
                                activeColor: AppColors.green,
                                activeTrackColor: AppColors.lightgreen,
                                inactiveThumbColor: AppColors.red,
                                inactiveTrackColor: AppColors.lightGrey,
                                splashRadius: 3.0,
                                onChanged: (value) {
                                  cubitA.switched(index);
                                  cubitA.updateAreaStatus(
                                    index: index,
                                    areaRequest: AreaRequest(
                                      id: cubitA.areaList[index].id,
                                      active:
                                          cubitA.areaList[index].active.isOdd
                                              ? 1
                                              : 0,
                                    ),
                                    //indexs: index,
                                  );
                                }),
                            SizedBox(
                              width: 1.w,
                            ),
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
                                  cubitA.deleteArea(
                                      areaModel: cubitA.areaList[index]);
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
