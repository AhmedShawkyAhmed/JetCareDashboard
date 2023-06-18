import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/business_logic/equipment_cuibt/equipment_cubit.dart';
import 'package:jetboard/src/data/network/requests/equipment_request.dart';
import 'package:jetboard/src/data/network/requests/equipment_schedule_request.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../business_logic/equipment_schedule_cuibt/equipment_schedule_cubit.dart';
import '../../business_logic/global_cubit/global_cubit.dart';
import '../../constants/constants_methods.dart';
import '../styles/app_colors.dart';
import '../views/loading_view.dart';
import '../views/row_data.dart';
import '../widgets/default_app_button.dart';
import '../widgets/default_text_field.dart';

class EquipmentScheduleDesktop extends StatefulWidget {
  const EquipmentScheduleDesktop({super.key});

  @override
  State<EquipmentScheduleDesktop> createState() =>
      _EquipmentScheduleDesktopState();
}

class _EquipmentScheduleDesktopState extends State<EquipmentScheduleDesktop> {
  TextEditingController code = TextEditingController();
  TextEditingController name = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime? selectedDate = DateTime.now();
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
                          code.clear();
                          name.clear();
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
                                        text: "Add New Equipment",
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
                                        controller: code,
                                        decoration: InputDecoration(
                                          hintText: 'Code',
                                          alignLabelWithHint: true,
                                          hintStyle: TextStyle(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.7),
                                            fontSize: 3.sp,
                                          ),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: AppColors.transparent,
                                        ),
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
                                        controller: name,
                                        decoration: InputDecoration(
                                          alignLabelWithHint: true,
                                          hintText: 'Name',
                                          hintStyle: TextStyle(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.7),
                                            fontSize: 3.sp,
                                          ),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: AppColors.transparent,
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
                                    // EquipmentScheduleCubit.get(context).addEquipment(
                                    //     equipmentRequest: EquipmentRequest(
                                    //   code: code.text,
                                    //   name: name.text,
                                    // ));
                                    code.clear();
                                    name.clear();
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
                                  )),
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
                                  )),
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
                                        EquipmentScheduleCubit.get(context)
                                            .equipmentList[index]
                                            .date
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
                                                int eqID =
                                                    EquipmentScheduleCubit.get(
                                                            context)
                                                        .equipmentList[index]
                                                        .id!;
                                                        print(eqID);
                                                final DateTime? picked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: selectedDate!,
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime(2100),
                                                );

                                                if (picked != null) {
                                                  String formattedDate =
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(picked);

                                                  //printResponse(formattedDate);
                                                  setState(() {
                                                    String? selectedDate1 =
                                                        formattedDate;
                                                    print(eqID);
                                                    print(EquipmentScheduleCubit
                                                            .get(context)
                                                        .equipmentList[index]
                                                        .equipment!
                                                        .id);
                                                    EquipmentScheduleCubit.get(
                                                            context)
                                                        .addReturnDate(
                                                            equipmentScheduleRequest:
                                                                EquipmentScheduleRequest(
                                                      id: eqID,
                                                      returned: selectedDate1,
                                                    ));
                                                  });
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: AppColors.grey,
                                              ))
                                          : Text(
                                              EquipmentScheduleCubit.get(
                                                      context)
                                                  .equipmentList[index]
                                                  .returned
                                                  .toString(),
                                              style: TextStyle(fontSize: 3.sp),
                                            ),
                                    ],
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
