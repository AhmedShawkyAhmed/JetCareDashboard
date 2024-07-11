import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/features/info/cubit/info_cubit.dart';
import 'package:jetboard/src/features/info/ui/views/add_info_view.dart';
import 'package:sizer/sizer.dart';

class InfoView extends StatefulWidget {
  final InfoCubit cubit;

  const InfoView({
    required this.cubit,
    super.key,
  });

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        itemCount: widget.cubit.info!.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            top: 2.h,
            left: 3.2.w,
            right: 2.5.w,
            bottom: 1.h,
          ),
          child: RowData(
            rowHeight: 9.h,
            data: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TitleEn',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.info![index].titleEn ?? "",
                      style: TextStyle(fontSize: 3.sp),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ContentEn',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.info![index].contentEn ?? "",
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
                      'TitleAr',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.info![index].titleAr ?? "",
                      style: TextStyle(fontSize: 3.sp),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ContentAr',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.info![index].contentAr ?? "",
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
                      'Type',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.info![index].type ?? "",
                      style: TextStyle(fontSize: 3.sp),
                    ),
                  ],
                ),
              ),
              AddInfoView(
                title: "Update",
                cubit: widget.cubit,
                info: widget.cubit.info![index],
              ),
              SizedBox(
                width: 2.w,
              ),
              IconButton(
                onPressed: () {
                  widget.cubit.deleteInfo(id: widget.cubit.info![index].id!);
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
