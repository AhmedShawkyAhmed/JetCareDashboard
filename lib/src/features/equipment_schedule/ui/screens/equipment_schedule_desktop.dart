import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/features/crew/cubit/crew_cubit.dart';
import 'package:jetboard/src/features/equipment_schedule/cubit/equipment_schedule_cubit.dart';
import 'package:jetboard/src/features/equipment_schedule/ui/views/add_schedule_view.dart';
import 'package:jetboard/src/features/equipment_schedule/ui/views/equipment_schedule_view.dart';
import 'package:jetboard/src/features/equipments/cubit/equipment_cubit.dart';
import 'package:sizer/sizer.dart';

class EquipmentScheduleDesktop extends StatefulWidget {
  const EquipmentScheduleDesktop({super.key});

  @override
  State<EquipmentScheduleDesktop> createState() =>
      _EquipmentScheduleDesktopState();
}

class _EquipmentScheduleDesktopState extends State<EquipmentScheduleDesktop> {
  EquipmentScheduleCubit cubit = EquipmentScheduleCubit(instance());
  EquipmentCubit equipmentCubit = EquipmentCubit(instance());
  CrewCubit crewCubit = CrewCubit(instance());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => cubit..getEquipmentSchedule(),
        ),
        BlocProvider(
          create: (context) => equipmentCubit..getActiveEquipment(),
        ),
        BlocProvider(
          create: (context) => crewCubit..getCrew(),
        ),
      ],
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
                      AddScheduleView(
                        cubit: cubit,
                        equipmentCubit: equipmentCubit,
                        crewCubit: crewCubit,
                      ),
                    ],
                  ),
                ),
                BlocBuilder<EquipmentScheduleCubit, EquipmentScheduleState>(
                  builder: (context, state) {
                    if (cubit.schedules == null) {
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
                    } else if (cubit.schedules!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: DefaultText(
                          text: "No Schedules Found !",
                          fontSize: 5.sp,
                        ),
                      );
                    }
                    return EquipmentScheduleView(cubit: cubit);
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
