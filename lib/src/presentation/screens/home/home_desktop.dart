import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/home_card.dart';
import 'package:jetboard/src/presentation/views/month_item.dart';
import 'package:jetboard/src/presentation/widgets/circular_item.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/indicator_view.dart';
import 'package:sizer/sizer.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({super.key});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 3.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<GlobalCubit, GlobalState>(
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
                                  GlobalCubit.get(context).getStatistics(
                                    month: (selectedMonth + 1).toString(),
                                    year: val,
                                    afterSuccess: () {},
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
                                    ? AppColors.pc
                                    : AppColors.lightGrey,
                                textColor: selectedMonth == index
                                    ? AppColors.white
                                    : AppColors.darkGrey,
                                onTap: () {
                                  setState(() {
                                    IndicatorView.showIndicator(context);
                                    selectedMonth = index;
                                    printError((selectedMonth + 1).toString());
                                  });
                                  GlobalCubit.get(context).getStatistics(
                                    month: (selectedMonth + 1).toString(),
                                    afterSuccess: () {
                                      Navigator.pop(context);
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
                              percent: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.completed ??
                                  0,
                              count: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.count ??
                                  1,
                              title: "Completed",
                              color: Colors.green,
                            ),
                            CircularItem(
                              percent: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.accepted ??
                                  0,
                              count: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.count ??
                                  1,
                              title: "Accepted",
                              color: Colors.blueAccent,
                            ),
                            CircularItem(
                              percent: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.confirmed ??
                                  0,
                              count: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.count ??
                                  1,
                              title: "Confirmed",
                              color: Colors.teal,
                            ),
                            CircularItem(
                              percent: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.assigned ??
                                  0,
                              count: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.count ??
                                  1,
                              title: "Assigned",
                              color: Colors.cyan,
                            ),
                            CircularItem(
                              percent: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.unassigned ??
                                  0,
                              count: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.count ??
                                  1,
                              title: "Not Assigned",
                              color: Colors.black38,
                            ),
                            CircularItem(
                              percent: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.rejected ??
                                  0,
                              count: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.count ??
                                  1,
                              title: "Rejected",
                              color: Colors.orange,
                            ),
                            CircularItem(
                              percent: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.canceled ??
                                  0,
                              count: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.count ??
                                  1,
                              title: "Canceled",
                              color: Colors.red,
                            ),
                            CircularItem(
                              percent: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.corporate ??
                                  0,
                              count: GlobalCubit.get(context)
                                      .statisticsResponse
                                      ?.orders
                                      ?.count ??
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
                    total: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.orders
                        ?.count ??
                        1,
                    percent: ((GlobalCubit.get(context)
                        .statisticsResponse
                        ?.orders
                        ?.count ??
                        0) -
                        (GlobalCubit.get(context)
                            .statisticsResponse
                            ?.orders
                            ?.corporate ??
                            0)),
                    percent2: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.orders
                        ?.corporate ??
                        1,
                  ),
                  HomeCard(
                    cWidth: 38.w,
                    title: "Payment",
                    title1: "Completed",
                    title2: "InProgress",
                    total: ((GlobalCubit.get(context)
                        .statisticsResponse
                        ?.orders
                        ?.complete ??
                        0) +
                        (GlobalCubit.get(context)
                            .statisticsResponse
                            ?.orders
                            ?.out ??
                            1)),
                    percent: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.orders
                        ?.complete ??
                        0,
                    percent2: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.orders
                        ?.out ??
                        1,
                  ),
                  HomeCard(
                    cWidth: 25.w,
                    title: "Clients",
                    total: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.client
                        ?.count ??
                        1,
                    percent: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.client
                        ?.active ??
                        0,
                    percent2: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.client
                        ?.disabled ??
                        0,
                  ),
                  HomeCard(
                    cWidth: 25.w,
                    title: "Crews",
                    total: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.crew
                        ?.count ??
                        1,
                    percent: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.crew
                        ?.active ??
                        0,
                    percent2: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.crew
                        ?.disabled ??
                        0,
                  ),
                  HomeCard(
                    cWidth: 24.w,
                    title: "Ads",
                    total: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.ads
                        ?.count ??
                        1,
                    percent: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.ads
                        ?.active ??
                        0,
                    percent2: GlobalCubit.get(context)
                        .statisticsResponse
                        ?.ads
                        ?.disabled ??
                        0,
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
    );
  }
}
