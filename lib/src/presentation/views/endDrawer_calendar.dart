import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/data/network/requests/calendar_request.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/calendar/calendar_cubit.dart';
import '../../business_logic/global_cubit/global_cubit.dart';
import '../../data/models/calendar_model.dart';
import '../styles/app_colors.dart';
import '../widgets/default_app_button.dart';
import '../widgets/default_text_field.dart';

class EndDrawerWidgetCalendar extends StatefulWidget {
  EndDrawerWidgetCalendar({
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
    this.calendarModel,
    required this.isEdit,
    this.pickedDate,
    //this.datess,
  });
  CalendarModel? calendarModel;
  bool isEdit;
  double? endDrawerWidth;
  double? heightBackButton, widthBackButton, fontTitle, fontAllTextField;
  double? heightButton, widthButton, fontButton;
  int? index;
  DateTime? pickedDate;
  //List<String>? datess = [];

  @override
  State<EndDrawerWidgetCalendar> createState() =>
      _EndDrawerWidgetCalendarState();
}

class _EndDrawerWidgetCalendarState extends State<EndDrawerWidgetCalendar> {
  final TextEditingController price = TextEditingController();
  final TextEditingController requests = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController dates = TextEditingController();
  TextEditingController date = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> datess = [];
  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      price.text = widget.calendarModel?.price.toString() ?? "";
      requests.text = widget.calendarModel?.requests.toString() ?? "";
      month.text = widget.calendarModel?.month.toString() ?? "";
      year.text = widget.calendarModel?.year.toString() ?? "";
      //dateInput.text = widget.calendarModel?.date.toString() ?? "";
      //dates.text = widget.calendarModel?..toString() ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = GlobalCubit.get(context);
    var cubitC = CalendarCubit.get(context);

    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 100.h,
              width: widget.endDrawerWidth ?? 23.w,
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.only(bottom: 25.h, left: 1.w, top: 3.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 4.w),
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
                            cubit.isedit ? 'Update Info' : 'Add New Info',
                            style:
                                TextStyle(fontSize: widget.fontTitle ?? 6.sp),
                          ),
                        ],
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 7.h, left: 3.w, right: 3.w),
                          child: Container(
                            //alignment: Alignment.center,
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
                                  offset: Offset(
                                      1, 1), // changes position of shadow
                                )
                              ],
                              border: Border.all(
                                color: AppColors.grey,
                                width: 1.5,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 4.sp,
                                ),
                                cursorColor: AppColors.darkGrey,
                                maxLines: 1,
                                controller: month,
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  hintStyle: TextStyle(
                                    color: AppColors.darkGrey.withOpacity(0.7),
                                    fontSize: 4.sp,
                                  ),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: AppColors.transparent,
                                  hintText: dateInput.text == ''
                                      ? 'Month'
                                      : DateFormat('MMMM')
                                          .format(widget.pickedDate!),
                                ),
                                readOnly: true,
                              ),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            //vertical: 3.h,
                          ),
                          child: Container(
                            //alignment: Alignment.center,
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
                                  offset: Offset(
                                      1, 1), // changes position of shadow
                                )
                              ],
                              border: Border.all(
                                color: AppColors.grey,
                                width: 1.5,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 4.sp,
                                ),
                                cursorColor: AppColors.darkGrey,
                                maxLines: 1,
                                controller: year,
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  hintStyle: TextStyle(
                                    color: AppColors.darkGrey.withOpacity(0.7),
                                    fontSize: 4.sp,
                                  ),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: AppColors.transparent,
                                  hintText: dateInput.text == ''
                                      ? 'Year'
                                      : DateFormat('yyyy')
                                          .format(widget.pickedDate!),
                                ),
                                readOnly: true,
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          //vertical: 3.h,
                        ),
                        child: DefaultTextField(
                          validator: requests.text,
                          password: false,
                          height: 7.h,
                          fontSize: widget.fontAllTextField ?? 4.sp,
                          controller: requests,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'Requests',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          //vertical: 3.h,
                        ),
                        child: DefaultTextField(
                          validator: price.text,
                          password: false,
                          height: 7.h,
                          fontSize: widget.fontAllTextField ?? 4.sp,
                          controller: price,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'Price',
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
                          controller: dateInput,
                          decoration: InputDecoration(
                            hintText: cubit.isedit
                                ? widget.calendarModel?.date
                                : 'Date',
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                              color: AppColors.darkGrey.withOpacity(0.7),
                              fontSize: 4.sp,
                            ),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: AppColors.transparent,
                            icon: Icon(
                              Icons.calendar_today,
                              color: AppColors.darkGrey.withOpacity(0.7),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            widget.pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));

                            if (widget.pickedDate != null) {
                              String formattedDate = DateFormat('dd-MM-yyyy')
                                  .format(widget.pickedDate!);

                              printResponse(formattedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                                datess.add(formattedDate);
                                printSuccess(datess.toString());
                              });
                            } else {}
                          },
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            //vertical: 3.h,
                          ),
                          child: Container(
                              //alignment: Alignment.center,
                              height: 15.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(
                                        1, 1), // changes position of shadow
                                  )
                                ],
                                border: Border.all(
                                  color: AppColors.grey,
                                  width: 1.5,
                                ),
                              ),
                              child: ListView.builder(
                                itemCount: datess.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          left: 1.w, right: 1.w),
                                      child: Row(
                                        children: [
                                          Text(
                                            datess[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 4.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                datess.removeAt(index);
                                                printSuccess(datess.toString());
                                              });
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: AppColors.darkGrey
                                                .withOpacity(0.5),
                                          )
                                        ],
                                      ));
                                },
                              ))),
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
                                    cubitC.updatecalendar(
                                        index: widget.index!,
                                        calendarRquest: CalendarRquest(
                                          id: widget.calendarModel!.id,
                                          areaId: 1,
                                          date: datess,
                                          month: DateFormat('MMMM')
                                              .format(widget.pickedDate!),
                                          day: '22',
                                          year: DateFormat('yyyy')
                                              .format(widget.pickedDate!),
                                          price: double.parse(price.text),
                                          requests: int.parse(requests.text),
                                        ));
                                    dateInput.clear();
                                    price.clear();
                                    requests.clear();
                                    Navigator.pop(context);
                                  }
                                : () {
                                    var formdata = formKey.currentState;
                                    if (formdata!.validate()) {
                                      cubitC.addcalendar(
                                          calendarRquest: CalendarRquest(
                                        areaId: 1,
                                        date: datess,
                                        month: DateFormat('MMMM')
                                            .format(widget.pickedDate!),
                                        day: '22',
                                        year: DateFormat('yyyy')
                                            .format(widget.pickedDate!),
                                        price: double.parse(price.text),
                                        requests: int.parse(requests.text),
                                      ));
                                      dateInput.clear();
                                      price.clear();
                                      requests.clear();
                                      //printResponse(cubiti.infoResponse!.status);
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
