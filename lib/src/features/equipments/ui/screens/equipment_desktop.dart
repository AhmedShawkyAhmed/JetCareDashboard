import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/equipments/cubit/equipment_cubit.dart';
import 'package:jetboard/src/features/equipments/ui/views/add_equipment_view.dart';
import 'package:jetboard/src/features/equipments/ui/views/equipment_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/shared/widgets/default_text_field.dart';

class EquipmentsDesktop extends StatefulWidget {
  const EquipmentsDesktop({super.key});

  @override
  State<EquipmentsDesktop> createState() => _EquipmentsDesktopState();
}

class _EquipmentsDesktopState extends State<EquipmentsDesktop> {
  EquipmentCubit cubit = EquipmentCubit(instance());
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getEquipment(),
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
                      DefaultTextField(
                        password: false,
                        width: 25.w,
                        height: 5.h,
                        fontSize: 3.sp,
                        color: AppColors.white,
                        bottom: 0.5.h,
                        hintText: 'Code / Name',
                        spreadRadius: 2,
                        blurRadius: 2,
                        shadowColor: AppColors.black.withOpacity(0.05),
                        haveShadow: true,
                        controller: searchController,
                        onChange: (value) {
                          if (value == "") {
                            cubit.getEquipment();
                          }
                        },
                        suffix: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            cubit.getEquipment(keyword: searchController.text);
                            printResponse(searchController.text);
                          },
                          color: AppColors.black,
                        ),
                      ),
                      const Spacer(),
                      AddEquipmentView(cubit: cubit),
                    ],
                  ),
                ),
                BlocBuilder<EquipmentCubit, EquipmentState>(
                  builder: (context, state) {
                    if (cubit.equipments == null) {
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
                    } else if (cubit.equipments!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: DefaultText(
                          text: "No Equipment Found !",
                          fontSize: 5.sp,
                        ),
                      );
                    }
                    return EquipmentView(cubit: cubit);
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
