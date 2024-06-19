import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/constants/constants_variables.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/month_item.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/features/home/cubit/home_cubit.dart';
import 'package:jetboard/src/features/home/ui/views/home_card.dart';
import 'package:jetboard/src/features/home/ui/views/statistics_view.dart';
import 'package:sizer/sizer.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({super.key});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  HomeCubit cubit = HomeCubit(instance());

  int selectedMonth = DateTime.now().month - 1;
  String year = (DateTime.now().year).toString();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getStatistics(showLoading: false),
      child: Padding(
        padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 3.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<HomeCubit, HomeState>(
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
                                items: yearList,
                                onChanged: (val) {
                                  setState(() {
                                    cubit.getStatistics(
                                      month: (selectedMonth + 1).toString(),
                                      year: val,
                                    );
                                    year = val!;
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
                                      cubit.getStatistics(
                                        month: (selectedMonth + 1).toString(),
                                      );
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    StatisticsView(orders: cubit.homeStatisticsModel.orders),
                    HomeCard(
                      cWidth: 38.w,
                      title: "Orders",
                      title1: "Clients",
                      title2: "Corporate",
                      total: cubit.homeStatisticsModel.orders?.count ?? 1,
                      percent: ((cubit.homeStatisticsModel.orders?.count ?? 0) -
                          (cubit.homeStatisticsModel.orders?.corporate ?? 0)),
                      percent2:
                          cubit.homeStatisticsModel.orders?.corporate ?? 1,
                    ),
                    HomeCard(
                      cWidth: 38.w,
                      title: "Payment",
                      title1: "Completed",
                      title2: "InProgress",
                      total:
                          ((cubit.homeStatisticsModel.orders?.complete ?? 0) +
                              (cubit.homeStatisticsModel.orders?.out ?? 1)),
                      percent: cubit.homeStatisticsModel.orders?.complete ?? 0,
                      percent2: cubit.homeStatisticsModel.orders?.out ?? 1,
                    ),
                    HomeCard(
                      cWidth: 25.w,
                      title: "Clients",
                      total: cubit.homeStatisticsModel.client?.count ?? 1,
                      percent: cubit.homeStatisticsModel.client?.isActive ?? 0,
                      percent2: cubit.homeStatisticsModel.client?.disabled ?? 0,
                    ),
                    HomeCard(
                      cWidth: 25.w,
                      title: "Crews",
                      total: cubit.homeStatisticsModel.crew?.count ?? 1,
                      percent: cubit.homeStatisticsModel.crew?.isActive ?? 0,
                      percent2: cubit.homeStatisticsModel.crew?.disabled ?? 0,
                    ),
                    HomeCard(
                      cWidth: 24.w,
                      title: "Ads",
                      total: cubit.homeStatisticsModel.ads?.count ?? 1,
                      percent: cubit.homeStatisticsModel.ads?.isActive ?? 0,
                      percent2: cubit.homeStatisticsModel.ads?.disabled ?? 0,
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
