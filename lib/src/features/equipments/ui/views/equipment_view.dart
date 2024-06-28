import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/features/equipments/cubit/equipment_cubit.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:sizer/sizer.dart';

class EquipmentView extends StatefulWidget {
  final EquipmentCubit cubit;

  const EquipmentView({
    required this.cubit,
    super.key,
  });

  @override
  State<EquipmentView> createState() => _EquipmentViewState();
}

class _EquipmentViewState extends State<EquipmentView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          itemCount: widget.cubit.equipments!.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              top: 2.h,
              left: 3.2.w,
              right: 2.5.w,
              bottom: 1.h,
            ),
            child: RowData(
              rowHeight: 8.h,
              data: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Code',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.equipments![index].code ?? "",
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.equipments![index].name ?? "",
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                  child: CircleAvatar(
                    backgroundColor:
                        widget.cubit.equipments![index].isActive == true
                            ? AppColors.green
                            : AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                SizedBox(
                  width: 1.w,
                ),
                SizedBox(
                  width: 2.w,
                ),
                IconButton(
                  onPressed: () {
                    widget.cubit.deleteEquipment(
                      id: widget.cubit.equipments![index].id!,
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
