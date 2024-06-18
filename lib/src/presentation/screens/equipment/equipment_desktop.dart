import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/equipment_cubit/equipment_cubit.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/data/network/requests/equipment_request.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../../core/shared/widgets/default_text_field.dart';

class EquipmentsDesktop extends StatefulWidget {
  const EquipmentsDesktop({super.key});

  @override
  State<EquipmentsDesktop> createState() => _EquipmentsDesktopState();
}

class _EquipmentsDesktopState extends State<EquipmentsDesktop> {
  TextEditingController searchController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
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
                    DefaultTextField(
                      password: false,
                      width: 25.w,
                      height: 5.h,
                      fontSize: 3.sp,
                      color: AppColors.white,
                      bottom: 0.5.h,
                      hintText: 'Code / Name',
                      spreadRadius: 2,
                      blurRadius: 2,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      haveShadow: true,
                      controller: searchController,
                      onChange: (value) {
                        if (value == "") {
                          EquipmentCubit.get(context).getEquipment();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          EquipmentCubit.get(context).getEquipment(keyword: searchController.text);
                          printResponse(searchController.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
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
                        AppColors.lightGreen,
                      ],
                      fontSize: 4.sp,
                      haveShadow: false,
                      title: "Add",
                      onTap: () {
                        setState(() {
                          codeController.clear();
                          nameController.clear();
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
                                        controller: codeController,
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
                                        controller: nameController,
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
                                    EquipmentCubit.get(context).addEquipment(
                                        equipmentRequest: EquipmentRequest(
                                      code: codeController.text,
                                      name: nameController.text,
                                    ));
                                    codeController.clear();
                                    nameController.clear();
                                    Navigator.pop(context);
                                  },
                                  width: 10.w,
                                  height: 4.h,
                                  fontSize: 3.sp,
                                  textColor: AppColors.white,
                                  buttonColor: AppColors.primary,
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
              BlocBuilder<EquipmentCubit, EquipmentState>(
                builder: (context, state) {
                  if (EquipmentCubit.get(context)
                          .getEquipmentResponse
                          ?.equipmentModel ==
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
                  } else if (EquipmentCubit.get(context)
                      .getEquipmentResponse!
                      .equipmentModel!
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
                        itemCount: EquipmentCubit.get(context).listCount,
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
                                        EquipmentCubit.get(context)
                                            .equipmentList[index]
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
                                        EquipmentCubit.get(context)
                                            .equipmentList[index]
                                            .name
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor: EquipmentCubit.get(context)
                                              .equipmentList[index]
                                              .active ==
                                          1
                                      ? AppColors.green
                                      : AppColors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    EquipmentCubit.get(context).deleteEquipment(
                                        equipmentModel: EquipmentCubit.get(context).equipmentList[index]);
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
