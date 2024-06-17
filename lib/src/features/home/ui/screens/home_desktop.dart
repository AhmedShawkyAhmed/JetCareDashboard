import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/constants/constants_variables.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/features/home/cubit/home_cubit.dart';
import 'package:jetboard/src/presentation/views/home_card.dart';
import 'package:jetboard/src/presentation/views/month_item.dart';
import 'package:jetboard/src/presentation/widgets/circular_item.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:sizer/sizer.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({super.key});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  HomeCubit cubit = HomeCubit(instance());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getStatistics(),
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
                                items: [
                                  (DateTime.now().year - 3).toString(),
                                  (DateTime.now().year - 2).toString(),
                                  (DateTime.now().year - 1).toString(),
                                  (DateTime.now().year).toString(),
                                  (DateTime.now().year + 1).toString(),
                                ],
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
                                  title: month[index],
                                  color: selectedMonth == index
                                      ? AppColors.primary
                                      : AppColors.lightGrey,
                                  textColor: selectedMonth == index
                                      ? AppColors.white
                                      : AppColors.darkGrey,
                                  onTap: () {
                                    setState(() {
                                      cubit.getStatistics(
                                        month: (selectedMonth + 1).toString(),
                                      );
                                      selectedMonth = index;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    HomeCard(
                      cWidth: 78.w,
                      title: "Orders",
                      total: 1,
                      percent: 1,
                      percent2: 1,
                      widget: Padding(
                        padding: EdgeInsets.only(
                          left: 1.w,
                          right: 1.w,
                          top: 1.h,
                          bottom: 1.h,
                        ),
                        child: Center(
                          child: Wrap(
                            spacing: 1.w,
                            runSpacing: 2.h,
                            children: [
                              CircularItem(
                                percent: cubit.homeStatisticsModel.orders
                                        ?.completed ??
                                    0,
                                count:
                                    cubit.homeStatisticsModel.orders?.count ??
                                        1,
                                title: "Completed",
                                color: Colors.green,
                              ),
                              CircularItem(
                                percent: cubit
                                        .homeStatisticsModel.orders?.accepted ??
                                    0,
                                count:
                                    cubit.homeStatisticsModel.orders?.count ??
                                        1,
                                title: "Accepted",
                                color: Colors.blueAccent,
                              ),
                              CircularItem(
                                percent: cubit.homeStatisticsModel.orders
                                        ?.confirmed ??
                                    0,
                                count:
                                    cubit.homeStatisticsModel.orders?.count ??
                                        1,
                                title: "Confirmed",
                                color: Colors.teal,
                              ),
                              CircularItem(
                                percent: cubit
                                        .homeStatisticsModel.orders?.assigned ??
                                    0,
                                count:
                                    cubit.homeStatisticsModel.orders?.count ??
                                        1,
                                title: "Assigned",
                                color: Colors.cyan,
                              ),
                              CircularItem(
                                percent: cubit.homeStatisticsModel.orders
                                        ?.unassigned ??
                                    0,
                                count:
                                    cubit.homeStatisticsModel.orders?.count ??
                                        1,
                                title: "Not Assigned",
                                color: Colors.black38,
                              ),
                              CircularItem(
                                percent: cubit
                                        .homeStatisticsModel.orders?.rejected ??
                                    0,
                                count:
                                    cubit.homeStatisticsModel.orders?.count ??
                                        1,
                                title: "Rejected",
                                color: Colors.orange,
                              ),
                              CircularItem(
                                percent: cubit
                                        .homeStatisticsModel.orders?.canceled ??
                                    0,
                                count:
                                    cubit.homeStatisticsModel.orders?.count ??
                                        1,
                                title: "Canceled",
                                color: Colors.red,
                              ),
                              CircularItem(
                                percent: cubit.homeStatisticsModel.orders
                                        ?.corporate ??
                                    0,
                                count:
                                    cubit.homeStatisticsModel.orders?.count ??
                                        1,
                                title: "Corporate",
                                color: Colors.purple,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                    // HomeCard(
                    //   title: "Categories",
                    //   total: GlobalCubit.get(context)
                    //           .statisticsResponse
                    //           ?.category
                    //           ?.count ??
                    //       1,
                    //   percent: GlobalCubit.get(context)
                    //           .statisticsResponse
                    //           ?.category
                    //           ?.active ??
                    //       0,
                    //   percent2: GlobalCubit.get(context)
                    //           .statisticsResponse
                    //           ?.category
                    //           ?.disabled ??
                    //       0,
                    // ),
                    // HomeCard(
                    //   title: "Packages",
                    //   total: GlobalCubit.get(context)
                    //           .statisticsResponse
                    //           ?.package
                    //           ?.count ??
                    //       1,
                    //   percent: GlobalCubit.get(context)
                    //           .statisticsResponse
                    //           ?.package
                    //           ?.active ??
                    //       0,
                    //   percent2: GlobalCubit.get(context)
                    //           .statisticsResponse
                    //           ?.package
                    //           ?.disabled ??
                    //       0,
                    // ),
                    // HomeCard(
                    //   title: "Items",
                    //   total: GlobalCubit.get(context)
                    //           .statisticsResponse
                    //           ?.item
                    //           ?.count ??
                    //       1,
                    //   percent: GlobalCubit.get(context)
                    //           .statisticsResponse
                    //           ?.item
                    //           ?.active ??
                    //       0,
                    //   percent2: GlobalCubit.get(context)
                    //           .statisticsResponse
                    //           ?.item
                    //           ?.disabled ??
                    //       0,
                    // ),
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
