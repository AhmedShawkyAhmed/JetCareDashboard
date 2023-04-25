import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/category_cubit/category_cubit.dart';
import '../../business_logic/period_cubit/period_cubit.dart';
import '../../constants/constants_methods.dart';
import '../styles/app_colors.dart';
import '../widgets/default_app_button.dart';

class AddPeriod extends StatefulWidget {
  int? periodId;
  AddPeriod({super.key, 
    this.periodId,
  });
  @override
  State<AddPeriod> createState() => _AddPeriodState();
}

class _AddPeriodState extends State<AddPeriod> {
  List<bool> isChecked = List.generate(2000, (index) => false);
  List<int> periodsId = [];

  @override
  Widget build(BuildContext context) {
    var cubitC = CategoryCubit.get(context);
    var cubitP = PeriodCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
        padding: EdgeInsets.only(left: 1.w, top: 1.h),
        height: 80.h,
        width: 80.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
              color: AppColors.darkGrey.withOpacity(0.5),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: Text(
                'Add Packages',
                style: TextStyle(fontSize: 5.sp),
              ),
            ),
            SizedBox(height: 1.h,),
            SizedBox(
              height: 55.h,
              width: 57.w,
              child: BlocBuilder<PeriodCubit, PeriodState>(
                builder: (context, state) {
                  return ListView.builder(
                      itemCount: cubitP.periodList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: 2.h, left: 3.2.w, right: 2.5.w, bottom: 1.h),
                          child: RowData(
                            rowHeight: 8.h,
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
                                    cubitP.periodList[index].id.toString(),
                                    style: TextStyle(fontSize: 3.sp),
                                  )
                                ],
                              ),
                              Expanded(
                                  flex: 2,
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
                                        cubitP.periodList[index].from ?? "",
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
                                        'To',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        cubitP.periodList[index].to ?? "",
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              
                              Checkbox(
                                value: periodsId
                                        .contains(cubitP.periodList[index].id)
                                    ? true
                                    : isChecked[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked[index] = value!;
                                    if (isChecked[index]) {
                                      periodsId
                                          .add(cubitP.periodList[index].id!);
                                    } else {
                                      periodsId
                                          .remove(cubitP.periodList[index].id);
                                    }
                                    printResponse(
                                        periodsId.join(' - ').toString());
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w,top: 1.h),
              child: DefaultAppButton(
                  width: 6.w,
                  height: 4.h,
                  haveShadow: true,
                  offset: const Offset(0, 0),
                  spreadRadius: 2,
                  blurRadius: 2,
                  radius: 10,
                  gradientColors: const [
                    AppColors.green,
                    AppColors.lightgreen,
                  ],
                  fontSize: 4.sp,
                  title: 'Add',
                  onTap: () {
                    // cubitC.addCategoryPeriod(
                    //     periodRequest: PeriodRequest(
                    //   id: widget.periodId,
                    //   //calendarId: cubitC.categoryList[index].id,
                    // ));
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
