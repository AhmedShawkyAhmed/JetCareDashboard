import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/features/areas/cubit/areas_cubit.dart';
import 'package:jetboard/src/features/areas/ui/views/add_area_view.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:sizer/sizer.dart';

class AreaView extends StatefulWidget {
  final AreasCubit cubit;

  const AreaView({
    required this.cubit,
    super.key,
  });

  @override
  State<AreaView> createState() => _AreaViewState();
}

class _AreaViewState extends State<AreaView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        itemCount: widget.cubit.areas!.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            top: 2.h,
            left: 3.2.w,
            right: 2.5.w,
            bottom: 1.h,
          ),
          child: RowData(
            rowHeight: 7.h,
            data: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'English Name',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.areas![index].nameEn ?? "",
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
                      'Arabic Name',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.areas![index].nameAr ?? "",
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
                      'Price',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.areas![index].price.toString(),
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
                      'Transportation',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.areas![index].transportation.toString(),
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
                      'Discount',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.areas![index].discount.toString(),
                      style: TextStyle(fontSize: 3.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
                child: CircleAvatar(
                  backgroundColor: widget.cubit.areas![index].isActive == true
                      ? AppColors.green
                      : AppColors.red,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Switch(
                value:
                    widget.cubit.areas![index].isActive == true ? true : false,
                activeColor: AppColors.green,
                activeTrackColor: AppColors.lightGreen,
                inactiveThumbColor: AppColors.red,
                inactiveTrackColor: AppColors.lightGrey,
                splashRadius: 3.0,
                onChanged: (value) {
                  widget.cubit.switched(widget.cubit.areas![index]);
                },
              ),
              SizedBox(
                width: 1.w,
              ),
              AddAreaView(
                title: "Update",
                cubit: widget.cubit,
                area: widget.cubit.areas![index],
              ),
              SizedBox(
                width: 2.w,
              ),
              IconButton(
                onPressed: () {
                  widget.cubit.deleteArea(id: widget.cubit.areas![index].id!);
                },
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.red,
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
