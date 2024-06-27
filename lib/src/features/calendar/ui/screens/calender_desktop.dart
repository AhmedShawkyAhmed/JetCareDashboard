import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/constants/constants_variables.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/views/month_item.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/areas/cubit/areas_cubit.dart';
import 'package:jetboard/src/features/calendar/cubit/calendar_cubit.dart';
import 'package:jetboard/src/features/calendar/ui/views/calender_view.dart';
import 'package:jetboard/src/features/calendar/ui/views/create_calender_view.dart';
import 'package:jetboard/src/features/periods/cubit/period_cubit.dart';
import 'package:sizer/sizer.dart';

class CalenderDesktop extends StatefulWidget {
  const CalenderDesktop({super.key});

  @override
  State<CalenderDesktop> createState() => _CalenderDesktopState();
}

class _CalenderDesktopState extends State<CalenderDesktop> {
  CalendarCubit cubit = CalendarCubit(instance());
  AreasCubit areasCubit = AreasCubit(instance());
  PeriodCubit periodCubit = PeriodCubit(instance());

  int selectedMonth = DateTime.now().month - 1;
  String year = (DateTime.now().year).toString();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => cubit..getCalendar(),
        ),
        BlocProvider(
          create: (context) => areasCubit..getAllAreas(),
        ),
        BlocProvider(
          create: (context) => periodCubit..getPeriods(),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 3.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<CalendarCubit, CalendarState>(
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
                                    cubit.getCalendar(
                                      month: (selectedMonth + 1),
                                      year: int.parse(val!),
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
                                  title: monthList[index],
                                  color: selectedMonth == index
                                      ? AppColors.primary
                                      : AppColors.lightGrey,
                                  textColor: selectedMonth == index
                                      ? AppColors.white
                                      : AppColors.darkGrey,
                                  onTap: () {
                                    setState(() {
                                      selectedMonth = index;
                                      printError(
                                          (selectedMonth + 1).toString());
                                    });
                                    cubit.getCalendar(
                                      month: (selectedMonth + 1),
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
                        itemCount: cubit.calendar!.isEmpty
                            ? 30
                            : cubit.calendar!.length,
                        itemBuilder: (context, index) {
                          return cubit.calendar!.isEmpty
                              ? LoadingView(
                                  width: 10.w,
                                  height: 10.h,
                                )
                              : CalenderView(
                                  onTap: () {
                                    showDialog<void>(
                                      context: NavigationService.context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return CreateCalenderView(
                                          cubit: cubit,
                                          areas: areasCubit.areas!,
                                          periods: periodCubit.periods!,
                                          calendarModel: cubit.calendar![index],
                                        );
                                      },
                                    );
                                  },
                                  calendarModel: cubit.calendar![index],
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
      ),
    );
  }
}
