import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/data/models/period_model.dart';
import 'package:jetboard/src/data/network/requests/period_request.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/global_cubit/global_cubit.dart';
import '../../business_logic/period_cubit/period_cubit.dart';
import '../../constants/constants_methods.dart';
import '../styles/app_colors.dart';
import '../widgets/default_app_button.dart';

class EndDrawerWidgetPeriod extends StatefulWidget {
  EndDrawerWidgetPeriod({
    super.key,
    this.endDrawerWidth,
    this.heightBackButton,
    this.widthBackButton,
    this.fontTitle,
    this.fontAllTextField,
    this.heightButton,
    this.widthButton,
    this.fontButton,
    this.index,
    this.periodModel,
    required this.isEdit,
  });
  double? endDrawerWidth;
  double? heightBackButton, widthBackButton, fontTitle, fontAllTextField;
  double? heightButton, widthButton, fontButton;
  bool isEdit;
  PeriodModel? periodModel;
  int? index;

  @override
  State<EndDrawerWidgetPeriod> createState() => _EndDrawerWidgetPeriodState();
}

class _EndDrawerWidgetPeriodState extends State<EndDrawerWidgetPeriod> {
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      from.text = widget.periodModel?.from ?? "";
      to.text = widget.periodModel?.to ?? "";
    }
  }

  Future<void> selectTime(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = GlobalCubit.get(context);
    var cubitP = PeriodCubit.get(context);
    return BlocBuilder<PeriodCubit, PeriodState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: SingleChildScrollView(
            child: Container(
              width: widget.endDrawerWidth ?? 25.w,
              height: 100.h,
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40.h, left: 2.w, top: 3.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 3.w),
                            child: InkWell(
                              onTap: (() {
                                Navigator.pop(context);
                                cubit.isShadowE();
                              }),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width == 600 ? 1.5.w : 1.h),
                                alignment: Alignment.center,
                                height: widget.heightBackButton ?? 4.h,
                                width: widget.widthBackButton ?? 2.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        AppColors.green,
                                        AppColors.lightgreen,
                                      ]),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            cubit.isedit ? 'Update Package' : 'Add New Package',
                            style:
                                TextStyle(fontSize: widget.fontTitle ?? 6.sp),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3.w, right: 3.w),
                        padding: EdgeInsets.only(left: 1.w),
                        height: 7.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset:
                                  Offset(1, 1), // changes position of shadow
                            )
                          ],
                          border: Border.all(
                            color: AppColors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == '') {
                              return 'You Can\'t leave this field empty';
                            }
                            return null;
                          },
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            fontSize: 4.sp,
                          ),
                          cursorColor: AppColors.darkGrey,
                          maxLines: 1,
                          controller: from,
                          decoration: InputDecoration(
                            hintText: 'From',
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                              color: AppColors.darkGrey.withOpacity(0.7),
                              fontSize: 4.sp,
                            ),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: AppColors.transparent,
                            icon: Icon(
                              Icons.watch_later,
                              color: AppColors.darkGrey.withOpacity(0.7),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              printResponse(pickedTime.format(context));
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              String formattedTime =
                                  DateFormat('hh:mm:ss').format(parsedTime);
                              printResponse(formattedTime);
                              setState(() {
                                from.text = pickedTime.format(context);
                              });
                            } else {
                              printResponse("Time is not selected");
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3.w, right: 3.w),
                        padding: EdgeInsets.only(left: 1.w),
                        height: 7.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset:
                                  Offset(1, 1), // changes position of shadow
                            )
                          ],
                          border: Border.all(
                            color: AppColors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == '') {
                              return 'You Can\'t leave this field empty';
                            }
                            return null;
                          },
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            fontSize: 4.sp,
                          ),
                          cursorColor: AppColors.darkGrey,
                          maxLines: 1,
                          controller: to,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: 'To',
                            hintStyle: TextStyle(
                              color: AppColors.darkGrey.withOpacity(0.7),
                              fontSize: 4.sp,
                            ),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: AppColors.transparent,
                            icon: Icon(
                              Icons.watch_later,
                              color: AppColors.darkGrey.withOpacity(0.7),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              String formattedTime =
                                  DateFormat('hh:mm:ss').format(parsedTime);
                              printResponse(formattedTime); //output 14:59:00
                              setState(() {
                                to.text = pickedTime.format(context);
                              });
                            } else {
                              printResponse("Time is not selected");
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 3.w, right: 3.w, top: 5.h),
                        child: Container(
                          alignment: Alignment.center,
                          child: DefaultAppButton(
                            title: cubit.isedit ? 'Update' : 'Add',
                            radius: 10,
                            width: widget.widthButton ?? 8.w,
                            height: widget.heightButton ?? 5.h,
                            fontSize: widget.fontButton ?? 4.sp,
                            onTap: cubit.isedit
                                ? () {
                                    cubitP.updatePeriod(
                                      index: widget.index!,
                                      periodRequest: PeriodRequest(
                                        id: widget.periodModel!.id,
                                        from: from.text,
                                        to: to.text,
                                      ),
                                    );
                                    printSuccess(
                                        widget.periodModel!.id.toString());
                                    from.clear();
                                    to.clear();
                                    Navigator.pop(context);
                                  }
                                : () {
                                    var formdata = formKey.currentState;
                                    if (formdata!.validate()) {
                                      cubitP.addPeriod(
                                          periodRequest: PeriodRequest(
                                        from: from.text,
                                        to: to.text,
                                      ));
                                      from.clear();
                                      to.clear();
                                      Navigator.pop(context);
                                    } else {
                                      printResponse('not valid');
                                    }
                                  },
                            haveShadow: false,
                            gradientColors: const [
                              AppColors.green,
                              AppColors.lightgreen,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
