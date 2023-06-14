import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/data/network/requests/period_request.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../business_logic/period_cubit/period_cubit.dart';
import '../../../constants/constants_methods.dart';
import '../../styles/app_colors.dart';
import '../../views/loading_view.dart';
import '../../views/row_data.dart';
import '../../widgets/default_app_button.dart';

class PeriodsDesktop extends StatefulWidget {
  const PeriodsDesktop({super.key});

  @override
  State<PeriodsDesktop> createState() => _PeriodsDesktopState();
}

class _PeriodsDesktopState extends State<PeriodsDesktop> {
  TextEditingController search = TextEditingController();
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<int> itemsId = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
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
                    const Spacer(),
                    DefaultAppButton(
                      width: 8.w,
                      height: 5.h,
                      offset: const Offset(0, 0),
                      spreadRadius: 2,
                      blurRadius: 2,
                      radius: 10,
                      gradientColors: const [
                        AppColors.green,
                        AppColors.lightgreen,
                      ],
                      fontSize: 4.sp,
                      haveShadow: false,
                      title: "Add",
                      onTap: () {
                        setState(() {
                          GlobalCubit.get(context).isedit = false;
                          from.clear();
                          to.clear();
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
                                    const DefaultText(
                                        text: "Add New Time Period",
                                        align: TextAlign.center),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 3.w, right: 3.w, top: 2.h),
                                      padding: EdgeInsets.only(left: 1.w),
                                      height: 5.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white,
                                            spreadRadius: 5,
                                            blurRadius: 5,
                                            offset: Offset(1,
                                                1), // changes position of shadow
                                          )
                                        ],
                                        border: Border.all(
                                          color: AppColors.grey,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.left,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextStyle(
                                          color: AppColors.darkGrey,
                                          fontSize: 3.sp,
                                        ),
                                        cursorColor: AppColors.darkGrey,
                                        maxLines: 1,
                                        controller: from,
                                        decoration: InputDecoration(
                                          hintText: 'From',
                                          alignLabelWithHint: true,
                                          hintStyle: TextStyle(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.7),
                                            fontSize: 3.sp,
                                          ),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: AppColors.transparent,
                                          icon: Icon(
                                            Icons.watch_later,
                                            color: AppColors.darkGrey
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );

                                          if (pickedTime != null) {
                                            printResponse(
                                                pickedTime.format(context));
                                            DateTime parsedTime =
                                                DateFormat.jm().parse(pickedTime
                                                    .format(context)
                                                    .toString());
                                            String formattedTime =
                                                DateFormat('hh:mm:ss')
                                                    .format(parsedTime);
                                            printResponse(formattedTime);
                                            setState(() {
                                              from.text =
                                                  pickedTime.format(context);
                                            });
                                          } else {
                                            printResponse(
                                                "Time is not selected");
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 3.w, right: 3.w, top: 2.h),
                                      padding: EdgeInsets.only(left: 1.w),
                                      height: 5.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white,
                                            spreadRadius: 5,
                                            blurRadius: 5,
                                            offset: Offset(1,
                                                1), // changes position of shadow
                                          )
                                        ],
                                        border: Border.all(
                                          color: AppColors.grey,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.left,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextStyle(
                                          color: AppColors.darkGrey,
                                          fontSize: 3.sp,
                                        ),
                                        cursorColor: AppColors.darkGrey,
                                        maxLines: 1,
                                        controller: to,
                                        decoration: InputDecoration(
                                          alignLabelWithHint: true,
                                          hintText: 'To',
                                          hintStyle: TextStyle(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.7),
                                            fontSize: 3.sp,
                                          ),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: AppColors.transparent,
                                          icon: Icon(
                                            Icons.watch_later,
                                            color: AppColors.darkGrey
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );

                                          if (pickedTime != null) {
                                            DateTime parsedTime =
                                                DateFormat.jm().parse(pickedTime
                                                    .format(context)
                                                    .toString());
                                            String formattedTime =
                                                DateFormat('hh:mm:ss')
                                                    .format(parsedTime);
                                            printResponse(
                                                formattedTime); //output 14:59:00
                                            setState(() {
                                              to.text =
                                                  pickedTime.format(context);
                                            });
                                          } else {
                                            printResponse(
                                                "Time is not selected");
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: <Widget>[
                                DefaultAppButton(
                                  title: "Save",
                                  onTap: () {
                                    PeriodCubit.get(context).addPeriod(
                                        periodRequest: PeriodRequest(
                                      from: from.text,
                                      to: to.text,
                                    ));
                                    from.clear();
                                    to.clear();
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
                    )
                  ],
                ),
              ),
              BlocBuilder<PeriodCubit, PeriodState>(
                builder: (context, state) {
                  if (PeriodCubit.get(context).getPeriodResponse?.periodModel ==
                      null) {
                    return Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: SizedBox(
                        height: 79.h,
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                                top: 0.5.h, left: 3.2.w, right: 2.5),
                            child: LoadingView(
                              width: 90.w,
                              height: 5.h,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (PeriodCubit.get(context)
                      .getPeriodResponse!
                      .periodModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Periods Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount: PeriodCubit.get(context).listCount,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              top: 2.h, left: 3.2.w, right: 2.5.w, bottom: 1.h),
                          child: RowData(
                            rowHeight: 8.h,
                            data: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'From',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        PeriodCubit.get(context).periodList[index].from
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
                                        'To',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        PeriodCubit.get(context).periodList[index].to.toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor:
                                      PeriodCubit.get(context).periodList[index].active == 1
                                          ? AppColors.green
                                          : AppColors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Switch(
                                  value: PeriodCubit.get(context).periodList[index].active == 1
                                      ? true
                                      : false,
                                  activeColor: AppColors.green,
                                  activeTrackColor: AppColors.lightgreen,
                                  inactiveThumbColor: AppColors.red,
                                  inactiveTrackColor: AppColors.lightGrey,
                                  splashRadius: 3.0,
                                  onChanged: (value) {
                                    PeriodCubit.get(context).switched(index);
                                    PeriodCubit.get(context).updatePeriodStatus(
                                      indexs: index,
                                      periodRequest: PeriodRequest(
                                        id: PeriodCubit.get(context).periodList[index].id,
                                        active: PeriodCubit.get(context)
                                                .periodList[index].active!.isOdd
                                            ? 1
                                            : 0,
                                      ),
                                    );
                                  }),
                              SizedBox(
                                width: 1.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      GlobalCubit.get(context).isedit = true;
                                      from.text =
                                          PeriodCubit.get(context).periodList[index].from ?? "";
                                      to.text =
                                          PeriodCubit.get(context).periodList[index].to ?? "";
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
                                                const DefaultText(
                                                    text: "Update Time Period",
                                                    align: TextAlign.center),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 3.w,
                                                      right: 3.w,
                                                      top: 2.h),
                                                  padding: EdgeInsets.only(
                                                      left: 1.w),
                                                  height: 5.h,
                                                  width: 20.w,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        spreadRadius: 5,
                                                        blurRadius: 5,
                                                        offset: Offset(1,
                                                            1), // changes position of shadow
                                                      )
                                                    ],
                                                    border: Border.all(
                                                      color: AppColors.grey,
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    style: TextStyle(
                                                      color: AppColors.darkGrey,
                                                      fontSize: 3.sp,
                                                    ),
                                                    cursorColor:
                                                        AppColors.darkGrey,
                                                    maxLines: 1,
                                                    controller: from,
                                                    decoration: InputDecoration(
                                                      hintText: 'From',
                                                      alignLabelWithHint: true,
                                                      hintStyle: TextStyle(
                                                        color: AppColors
                                                            .darkGrey
                                                            .withOpacity(0.7),
                                                        fontSize: 3.sp,
                                                      ),
                                                      border: InputBorder.none,
                                                      filled: true,
                                                      fillColor:
                                                          AppColors.transparent,
                                                      icon: Icon(
                                                        Icons.watch_later,
                                                        color: AppColors
                                                            .darkGrey
                                                            .withOpacity(0.7),
                                                      ),
                                                    ),
                                                    readOnly: true,
                                                    onTap: () async {
                                                      TimeOfDay? pickedTime =
                                                          await showTimePicker(
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                        context: context,
                                                      );

                                                      if (pickedTime != null) {
                                                        printResponse(pickedTime
                                                            .format(context));
                                                        DateTime parsedTime =
                                                            DateFormat.jm()
                                                                .parse(pickedTime
                                                                    .format(
                                                                        context)
                                                                    .toString());
                                                        String formattedTime =
                                                            DateFormat(
                                                                    'hh:mm:ss')
                                                                .format(
                                                                    parsedTime);
                                                        printResponse(
                                                            formattedTime);
                                                        setState(() {
                                                          from.text = pickedTime
                                                              .format(context);
                                                        });
                                                      } else {
                                                        printResponse(
                                                            "Time is not selected");
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 3.w,
                                                      right: 3.w,
                                                      top: 2.h),
                                                  padding: EdgeInsets.only(
                                                      left: 1.w),
                                                  height: 5.h,
                                                  width: 20.w,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        spreadRadius: 5,
                                                        blurRadius: 5,
                                                        offset: Offset(1,
                                                            1), // changes position of shadow
                                                      )
                                                    ],
                                                    border: Border.all(
                                                      color: AppColors.grey,
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    style: TextStyle(
                                                      color: AppColors.darkGrey,
                                                      fontSize: 3.sp,
                                                    ),
                                                    cursorColor:
                                                        AppColors.darkGrey,
                                                    maxLines: 1,
                                                    controller: to,
                                                    decoration: InputDecoration(
                                                      alignLabelWithHint: true,
                                                      hintText: 'To',
                                                      hintStyle: TextStyle(
                                                        color: AppColors
                                                            .darkGrey
                                                            .withOpacity(0.7),
                                                        fontSize: 3.sp,
                                                      ),
                                                      border: InputBorder.none,
                                                      filled: true,
                                                      fillColor:
                                                          AppColors.transparent,
                                                      icon: Icon(
                                                        Icons.watch_later,
                                                        color: AppColors
                                                            .darkGrey
                                                            .withOpacity(0.7),
                                                      ),
                                                    ),
                                                    readOnly: true,
                                                    onTap: () async {
                                                      TimeOfDay? pickedTime =
                                                          await showTimePicker(
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                        context: context,
                                                      );

                                                      if (pickedTime != null) {
                                                        DateTime parsedTime =
                                                            DateFormat.jm()
                                                                .parse(pickedTime
                                                                    .format(
                                                                        context)
                                                                    .toString());
                                                        String formattedTime =
                                                            DateFormat(
                                                                    'hh:mm:ss')
                                                                .format(
                                                                    parsedTime);
                                                        printResponse(
                                                            formattedTime); //output 14:59:00
                                                        setState(() {
                                                          to.text = pickedTime
                                                              .format(context);
                                                        });
                                                      } else {
                                                        printResponse(
                                                            "Time is not selected");
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          actions: <Widget>[
                                            DefaultAppButton(
                                              title: "Save",
                                              onTap: () {
                                                PeriodCubit.get(context).updatePeriod(
                                                  index: index,
                                                  periodRequest: PeriodRequest(
                                                    id: PeriodCubit.get(context)
                                                        .periodList[index].id,
                                                    from: from.text,
                                                    to: to.text,
                                                  ),
                                                );
                                                from.clear();
                                                to.clear();
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
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.grey,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    PeriodCubit.get(context).deletePeriod(
                                        periodModel: PeriodCubit.get(context).periodList[index]);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.red,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                            ],
                          ),
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
