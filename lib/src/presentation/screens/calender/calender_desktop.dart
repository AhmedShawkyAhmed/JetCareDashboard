import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/calender_cubit/calender_cubit.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/constants/constants_variables.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/views/calender_view.dart';
import 'package:jetboard/src/presentation/views/month_item.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/indicator_view.dart';
import 'package:sizer/sizer.dart';

import '../../views/create_calender_view.dart';
import '../../views/loading_view.dart';

class CalenderDesktop extends StatefulWidget {
  const CalenderDesktop({super.key});

  @override
  State<CalenderDesktop> createState() => _CalenderDesktopState();
}

class _CalenderDesktopState extends State<CalenderDesktop> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 3.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CalenderCubit, CalenderState>(
            builder: (context, state) {
              return Wrap(
                spacing: 2.w,
                runSpacing: 4.h,
                children: [
                  SizedBox(
                    width: 81.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: SizedBox(
                            width: 10.w,
                            child: DefaultDropdown<String>(
                              hint: "Year",
                              showSearchBox: true,
                              selectedItem: year,
                              items: [
                                (DateTime.now().year).toString(),
                                (DateTime.now().year + 1).toString(),
                                (DateTime.now().year + 2).toString(),
                                (DateTime.now().year + 3).toString(),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  CalenderCubit.get(context).getCalender(
                                    month: (selectedMonth + 1),
                                    year: int.parse(val!),
                                    afterSuccess: () {},
                                  );
                                  year = val;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70.w,
                          height: 5.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 12,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return MonthItem(
                                title: month[index],
                                color: selectedMonth == index
                                    ? AppColors.primary
                                    : AppColors.lightGrey,
                                textColor: selectedMonth == index
                                    ? AppColors.white
                                    : AppColors.darkGrey,
                                onTap: () {
                                  setState(() {
                                    selectedMonth = index;
                                    printError((selectedMonth + 1).toString());
                                  });
                                  CalenderCubit.get(context).getCalender(
                                    month: (selectedMonth + 1),
                                    afterSuccess: () {
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 80.w,
                    height: 80.h,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 10,
                        childAspectRatio: (8.w / 12.h),
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: CalenderCubit.get(context).calenderList.isEmpty
                          ? 30
                          : CalenderCubit.get(context).calenderList.length,
                      itemBuilder: (context, index) {
                        return CalenderCubit.get(context).calenderList.isEmpty
                            ? LoadingView(
                                width: 10.w,
                                height: 10.h,
                              )
                            : CalenderView(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return CreateCalenderView(
                                        areas: CalenderCubit.get(context)
                                            .areaResponse!
                                            .areaModel!,
                                        periods: CalenderCubit.get(context)
                                            .periodResponse!
                                            .periodModel!,
                                        calenderModel:
                                            CalenderCubit.get(context)
                                                .calenderList[index],
                                      );
                                    },
                                  );
                                },
                                calenderModel: CalenderCubit.get(context)
                                    .calenderList[index],
                              );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
