import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/features/periods/cubit/period_cubit.dart';
import 'package:jetboard/src/features/periods/ui/views/add_period_view.dart';
import 'package:jetboard/src/features/periods/ui/views/period_view.dart';
import 'package:sizer/sizer.dart';

class PeriodsDesktop extends StatefulWidget {
  const PeriodsDesktop({super.key});

  @override
  State<PeriodsDesktop> createState() => _PeriodsDesktopState();
}

class _PeriodsDesktopState extends State<PeriodsDesktop> {
  PeriodCubit cubit = PeriodCubit(instance());
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getPeriods(),
      child: Scaffold(
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
                  padding: EdgeInsets.only(
                    top: 5.h,
                    left: 3.w,
                    right: 50,
                  ),
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
                          AppColors.lightGreen,
                        ],
                        fontSize: 4.sp,
                        haveShadow: false,
                        title: "Add",
                        onTap: () {
                          AddPeriodView.show(cubit: cubit);
                        },
                      )
                    ],
                  ),
                ),
                BlocBuilder<PeriodCubit, PeriodState>(
                  builder: (context, state) {
                    if (cubit.periods == null) {
                      return Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: SizedBox(
                          height: 79.h,
                          child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(
                                top: 0.5.h,
                                left: 3.2.w,
                                right: 2.5,
                              ),
                              child: LoadingView(
                                width: 90.w,
                                height: 5.h,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (cubit.periods!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: DefaultText(
                          text: "No Periods Found !",
                          fontSize: 5.sp,
                        ),
                      );
                    }
                    return PeriodView(cubit: cubit);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
