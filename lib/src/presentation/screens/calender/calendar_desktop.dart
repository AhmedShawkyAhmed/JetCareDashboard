import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/calendar/calendar_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/endDrawer_calendar.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class CalendarDesktop extends StatefulWidget {
  const CalendarDesktop({super.key});

  @override
  State<CalendarDesktop> createState() => _CalendarDesktopState();
}

class _CalendarDesktopState extends State<CalendarDesktop> {
  TextEditingController search = TextEditingController();
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  String dropdownvalue = 'Item 1';
  

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubitC = CalendarCubit.get(context);

    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      key: scaffoldkey,
      endDrawer: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          return EndDrawerWidgetCalendar(
            index: currentIndex,
            isEdit: cubit.isedit,
            calendarModel:
                cubitC.calendarList.isEmpty ? null : cubitC.calendarList[currentIndex],
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
                      hintText: 'Date',
                      spreadRadius: 2,
                      blurRadius: 2,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      haveShadow: true,
                      controller: search,
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          cubitC.getcalendar(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    // BlocBuilder<InfoCubit, InfoState>(
                    //   builder: (context, state) {
                    //     return InfoCubit.get(context).infoTypes.isEmpty
                    //         ? SizedBox()
                    //         : Container(
                    //             decoration: BoxDecoration(
                    //               color: AppColors.white,
                    //               borderRadius: BorderRadius.circular(10),
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: Colors.black.withOpacity(0.5),
                    //                   spreadRadius: 1,
                    //                   blurRadius: 2,
                    //                   offset: Offset(
                    //                       1, 1), // changes position of shadow
                    //                 )
                    //               ],
                    //             ),
                    //             width: 5.w,
                    //             child: DropdownButton(
                    //               icon:  Icon(
                    //                 Icons.keyboard_arrow_down,
                    //                size: 4.sp,
                    //               ),
                    //               underline: const SizedBox(),
                    //               value: cubiti.infoTypes.first,
                    //               items: cubiti.infoTypes
                    //                   .map<DropdownMenuItem<String>>((value) {
                    //                 return DropdownMenuItem<String>(
                    //                   value: value,
                    //                   child: Text(value),
                    //                 );
                    //               }).toList(),
                    //               onChanged: (String? value) {
                    //                 setState(() {
                    //                   dropdownvalue = value!;
                    //                   cubiti.getInfo(type: value);
                    //                   printResponse(value);
                    //                 });
                    //               },
                    //             ),
                    //           );
                    //   },
                    // ),
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
              BlocBuilder<CalendarCubit, CalendarState>(
                builder: (context, state) {
                  if (cubitC.calendarList.isEmpty) {
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
                  }
                  return SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      itemCount: CalendarCubit.get(context).listCount,
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
                                  CalendarCubit.get(context)
                                      .calendarList[index]
                                      .id
                                      .toString(),
                                  style: TextStyle(fontSize: 3.sp),
                                ),
                              ],
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'AreaId',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      CalendarCubit.get(context)
                                          .calendarList[index]
                                          .areaId.toString(),
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
                                      'Month',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      CalendarCubit.get(context)
                                          .calendarList[index]
                                          .month.toString(),
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
                                      'Year',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      CalendarCubit.get(context)
                                          .calendarList[index]
                                          .year.toString(),
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
                                      'Date',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      CalendarCubit.get(context)
                                          .calendarList[index]
                                          .date.toString(),
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
                                      'Requests',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      CalendarCubit.get(context)
                                          .calendarList[index]
                                          .requests.toString(),
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
                                      CalendarCubit.get(context)
                                          .calendarList[index]
                                          .price.toString(),
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
                              width: 4.w,
                            ),
                            // IconButton(
                            //       onPressed: () {
                            //         showDialog(context: context, builder: (context){
                            //           return AddPeriod(
                            //         periodId: cubitC.calendarList[index].id,
                            //        );
                            //         });
                            //       },
                            //       icon: const Icon(
                            //         Icons.add,
                            //         color: AppColors.grey,
                            //       )),
                              // IconButton(
                              //     onPressed: () {
                              //       showDialog(context: context, builder: (context){
                              //         return ViewItems(
                              //       itmes: cubitP.periodList[index].items,
                              //       indexs: index,
                              //      );
                              //       });
                              //     },
                              //     icon: const Icon(
                              //       Icons.remove_red_eye,
                              //       color: AppColors.grey,
                              //     )),
                              // SizedBox(
                              //   width: 2.w,
                              // ),
                            IconButton(
                                onPressed: () {
                                  cubitC.deletecalendar(
                                      calendarModel: cubitC.calendarList[index]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.red,
                                )),
                            SizedBox(
                              width: 5.w,
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
