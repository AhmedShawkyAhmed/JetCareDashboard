import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/features/states/cubit/states_cubit.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:sizer/sizer.dart';

class StateView extends StatefulWidget {
  final StatesCubit cubit;

  const StateView({
    required this.cubit,
    super.key,
  });

  @override
  State<StateView> createState() => _StateViewState();
}

class _StateViewState extends State<StateView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        itemCount: widget.cubit.states!.length,
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
                      widget.cubit.states![index].nameEn.toString(),
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
                      widget.cubit.states![index].nameAr.toString(),
                      style: TextStyle(fontSize: 3.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
                child: CircleAvatar(
                  backgroundColor: widget.cubit.states![index].isActive == true
                      ? AppColors.green
                      : AppColors.red,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Switch(
                value:
                    widget.cubit.states![index].isActive == true ? true : false,
                activeColor: AppColors.green,
                activeTrackColor: AppColors.lightGreen,
                inactiveThumbColor: AppColors.red,
                inactiveTrackColor: AppColors.lightGrey,
                splashRadius: 3.0,
                onChanged: (value) {
                  widget.cubit.switched(widget.cubit.states![index]);
                },
              ),
              SizedBox(
                width: 3.w,
              ),
              IconButton(
                onPressed: () {
                  widget.cubit.deleteState(
                    id: widget.cubit.states![index].id!,
                  );
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
