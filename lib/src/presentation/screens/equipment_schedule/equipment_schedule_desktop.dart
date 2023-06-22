import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/business_logic/equipment_cuibt/equipment_cubit.dart';
import 'package:jetboard/src/business_logic/equipment_schedule_cuibt/equipment_schedule_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/data/models/equipment_model.dart';
import 'package:jetboard/src/data/models/user_model.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class EquipmentScheduleDesktop extends StatefulWidget {
  const EquipmentScheduleDesktop({super.key});

  @override
  State<EquipmentScheduleDesktop> createState() =>
      _EquipmentScheduleDesktopState();
}

class _EquipmentScheduleDesktopState extends State<EquipmentScheduleDesktop> {
  TextEditingController dateController = TextEditingController();
  int crewId = 0;
  int eqId = 0;
  DateTime now = DateTime.now();

  Future<void> selectDate(
      BuildContext context, VoidCallback afterSuccess) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime(now.year, now.month, now.day + 1),
      firstDate: DateTime(now.year, now.month, now.day + 1),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.teal,
              primaryColorDark: Colors.teal,
              accentColor: Colors.teal,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd', 'en_US').format(picked);
      afterSuccess();
    }
  }

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
                        GlobalCubit.get(context).getUser(afterSuccess: () {
                          printLog(
                              GlobalCubit.get(context).crews.length.toString());
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
                                        text: "Handover Equipment",
                                        align: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      BlocBuilder<EquipmentCubit,
                                          EquipmentState>(
                                        builder: (context, state) {
                                          if (GlobalCubit.get(context)
                                              .users
                                              .isEmpty) {
                                            return SizedBox(
                                              width: 15.w,
                                              child: const DefaultText(
                                                text: "No Equipment",
                                                align: TextAlign.right,
                                              ),
                                            );
                                          }
                                          return SizedBox(
                                            width: 15.w,
                                            height: 4.h,
                                            child:
                                                DefaultDropdown<EquipmentModel>(
                                              hint: "Equipment",
                                              showSearchBox: true,
                                              itemAsString:
                                                  (EquipmentModel? u) =>
                                                      u?.name ?? "",
                                              items: EquipmentCubit.get(context)
                                                  .equipmentList,
                                              onChanged: (val) {
                                                setState(() {
                                                  eqId = val!.id!;
                                                });
                                                printLog(eqId.toString());
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      BlocBuilder<GlobalCubit, GlobalState>(
                                        builder: (context, state) {
                                          if (GlobalCubit.get(context)
                                              .users
                                              .isEmpty) {
                                            return SizedBox(
                                              width: 15.w,
                                              child: const DefaultText(
                                                text: "No Crew",
                                                align: TextAlign.right,
                                              ),
                                            );
                                          }
                                          return SizedBox(
                                            width: 15.w,
                                            height: 4.h,
                                            child: DefaultDropdown<UserModel>(
                                              hint: "Crew",
                                              showSearchBox: true,
                                              itemAsString: (UserModel? u) =>
                                                  u?.name ?? "",
                                              items: GlobalCubit.get(context)
                                                  .users,
                                              onChanged: (val) {
                                                setState(() {
                                                  crewId = val!.id;
                                                });
                                                printLog(crewId.toString());
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          selectDate(
                                            context,
                                            () {},
                                          );
                                        },
                                        child: DefaultTextField(
                                          controller: dateController,
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
                                          hintText: "Choose Date",
                                          password: false,
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
                                      EquipmentScheduleCubit.get(context)
                                          .assignEquipment(
                                        eqId: eqId,
                                        crewId: crewId,
                                        date: dateController.text,
                                        afterSuccess: () {
                                          dateController.clear();
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
                        });
                      },
                    )
                  ],
                ),
              ),
              BlocBuilder<EquipmentScheduleCubit, EquipmentScheduleState>(
                builder: (context, state) {
                  if (EquipmentScheduleCubit.get(context)
                          .getEquipmentScheduleResponse
                          ?.equipmentScheduleModel ==
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
                  } else if (EquipmentScheduleCubit.get(context)
                      .getEquipmentScheduleResponse!
                      .equipmentScheduleModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Equipment Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount:
                            EquipmentScheduleCubit.get(context).listCount,
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
                                      'Code',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      EquipmentScheduleCubit.get(context)
                                          .equipmentList[index]
                                          .equipment!
                                          .code
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
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
                                      EquipmentScheduleCubit.get(context)
                                          .equipmentList[index]
                                          .equipment!
                                          .name
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Crew',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      EquipmentScheduleCubit.get(context)
                                          .equipmentList[index]
                                          .crew!
                                          .name
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
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
                                      EquipmentScheduleCubit.get(context)
                                          .equipmentList[index]
                                          .date
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Return Date',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    EquipmentScheduleCubit.get(context)
                                                .equipmentList[index]
                                                .returned ==
                                            null
                                        ? IconButton(
                                            onPressed: () async {
                                              selectDate(
                                                context,
                                                () {
                                                  EquipmentScheduleCubit.get(
                                                          context)
                                                      .addReturnDate(
                                                    id: EquipmentScheduleCubit
                                                            .get(context)
                                                        .equipmentList[index]
                                                        .id!,
                                                    date: dateController.text,
                                                    afterSuccess: () {
                                                      setState(() {
                                                        EquipmentScheduleCubit
                                                                    .get(context)
                                                                .equipmentList[
                                                                    index]
                                                                .returned =
                                                            dateController.text;
                                                      });
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: AppColors.grey,
                                            ),
                                          )
                                        : Text(
                                            EquipmentScheduleCubit.get(context)
                                                .equipmentList[index]
                                                .returned
                                                .toString(),
                                            style: TextStyle(fontSize: 3.sp),
                                          ),
                                  ],
                                ),
                              ),
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
