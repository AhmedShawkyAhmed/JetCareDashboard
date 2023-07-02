import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/network/requests/period_request.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
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
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
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
                          fromController.clear();
                          toController.clear();
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
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                colorScheme:
                                                    ColorScheme.fromSwatch(
                                                  primarySwatch: Colors.teal,
                                                  primaryColorDark: Colors.teal,
                                                  accentColor: Colors.teal,
                                                ),
                                                dialogBackgroundColor:
                                                    Colors.white,
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (pickedTime != null) {
                                          setState(() {
                                            fromController.text =
                                                pickedTime.format(context);
                                          });
                                        } else {
                                          printResponse("Time is not selected");
                                        }
                                      },
                                      child: DefaultTextField(
                                        controller: fromController,
                                        height: 4.h,
                                        width: 15.w,
                                        haveShadow: true,
                                        readOnly: false,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        horizontalPadding: 0,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: "From",
                                        password: false,
                                        prefix: Icon(
                                          Icons.watch_later,
                                          color: AppColors.darkGrey
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                colorScheme:
                                                    ColorScheme.fromSwatch(
                                                  primarySwatch: Colors.teal,
                                                  primaryColorDark: Colors.teal,
                                                  accentColor: Colors.teal,
                                                ),
                                                dialogBackgroundColor:
                                                    Colors.white,
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (pickedTime != null) {
                                          setState(() {
                                            toController.text =
                                                pickedTime.format(context);
                                          });
                                        } else {
                                          printResponse("Time is not selected");
                                        }
                                      },
                                      child: DefaultTextField(
                                        controller: toController,
                                        height: 4.h,
                                        width: 15.w,
                                        haveShadow: true,
                                        readOnly: false,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        horizontalPadding: 0,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: "Choose Time",
                                        password: false,
                                        prefix: Icon(
                                          Icons.watch_later,
                                          color: AppColors.darkGrey
                                              .withOpacity(0.7),
                                        ),
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
                                      from: fromController.text,
                                      to: toController.text,
                                    ));
                                    fromController.clear();
                                    toController.clear();
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
                                        PeriodCubit.get(context)
                                            .periodList[index]
                                            .from
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
                                        PeriodCubit.get(context)
                                            .periodList[index]
                                            .to
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor: PeriodCubit.get(context)
                                              .periodList[index]
                                              .active ==
                                          1
                                      ? AppColors.green
                                      : AppColors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Switch(
                                  value: PeriodCubit.get(context)
                                              .periodList[index]
                                              .active ==
                                          1
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
                                        id: PeriodCubit.get(context)
                                            .periodList[index]
                                            .id,
                                        active: PeriodCubit.get(context)
                                                .periodList[index]
                                                .active!
                                                .isOdd
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
                                      fromController.text =
                                          PeriodCubit.get(context)
                                                  .periodList[index]
                                                  .from ??
                                              "";
                                      toController.text =
                                          PeriodCubit.get(context)
                                                  .periodList[index]
                                                  .to ??
                                              "";
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
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      context: context,
                                                      builder:
                                                          (BuildContext context,
                                                              Widget? child) {
                                                        return Theme(
                                                          data:
                                                              ThemeData.light()
                                                                  .copyWith(
                                                            colorScheme:
                                                                ColorScheme
                                                                    .fromSwatch(
                                                              primarySwatch:
                                                                  Colors.teal,
                                                              primaryColorDark:
                                                                  Colors.teal,
                                                              accentColor:
                                                                  Colors.teal,
                                                            ),
                                                            dialogBackgroundColor:
                                                                Colors.white,
                                                          ),
                                                          child: child!,
                                                        );
                                                      },
                                                    );
                                                    if (pickedTime != null) {
                                                      setState(() {
                                                        fromController.text =
                                                            pickedTime.format(
                                                                context);
                                                      });
                                                    } else {
                                                      printResponse(
                                                          "Time is not selected");
                                                    }
                                                  },
                                                  child: DefaultTextField(
                                                    controller: fromController,
                                                    height: 4.h,
                                                    width: 15.w,
                                                    haveShadow: true,
                                                    readOnly: false,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    horizontalPadding: 0,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors.black
                                                        .withOpacity(0.05),
                                                    hintText: "From",
                                                    password: false,
                                                    prefix: Icon(
                                                      Icons.watch_later,
                                                      color: AppColors.darkGrey
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      context: context,
                                                      builder:
                                                          (BuildContext context,
                                                              Widget? child) {
                                                        return Theme(
                                                          data:
                                                              ThemeData.light()
                                                                  .copyWith(
                                                            colorScheme:
                                                                ColorScheme
                                                                    .fromSwatch(
                                                              primarySwatch:
                                                                  Colors.teal,
                                                              primaryColorDark:
                                                                  Colors.teal,
                                                              accentColor:
                                                                  Colors.teal,
                                                            ),
                                                            dialogBackgroundColor:
                                                                Colors.white,
                                                          ),
                                                          child: child!,
                                                        );
                                                      },
                                                    );
                                                    if (pickedTime != null) {
                                                      setState(() {
                                                        toController.text =
                                                            pickedTime.format(
                                                                context);
                                                      });
                                                    } else {
                                                      printResponse(
                                                          "Time is not selected");
                                                    }
                                                  },
                                                  child: DefaultTextField(
                                                    controller: toController,
                                                    height: 4.h,
                                                    width: 15.w,
                                                    haveShadow: true,
                                                    readOnly: false,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    horizontalPadding: 0,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors.black
                                                        .withOpacity(0.05),
                                                    hintText: "Choose Time",
                                                    password: false,
                                                    prefix: Icon(
                                                      Icons.watch_later,
                                                      color: AppColors.darkGrey
                                                          .withOpacity(0.7),
                                                    ),
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
                                                PeriodCubit.get(context)
                                                    .updatePeriod(
                                                  index: index,
                                                  periodRequest: PeriodRequest(
                                                    id: PeriodCubit.get(context)
                                                        .periodList[index]
                                                        .id,
                                                    from: fromController.text,
                                                    to: toController.text,
                                                  ),
                                                );
                                                fromController.clear();
                                                toController.clear();
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
                                        periodModel: PeriodCubit.get(context)
                                            .periodList[index]);
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
