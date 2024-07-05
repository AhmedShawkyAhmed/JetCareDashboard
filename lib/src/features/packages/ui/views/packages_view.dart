import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/features/packages/cubit/packages_cubit.dart';
import 'package:jetboard/src/features/packages/ui/views/add_package_view.dart';
import 'package:jetboard/src/features/packages/ui/views/package_details_view.dart';
import 'package:sizer/sizer.dart';

class PackagesView extends StatefulWidget {
  final PackagesCubit cubit;

  const PackagesView({
    required this.cubit,
    super.key,
  });

  @override
  State<PackagesView> createState() => _PackagesViewState();
}

class _PackagesViewState extends State<PackagesView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          itemCount: widget.cubit.packages!.length,
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
                  flex: 2,
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
                        widget.cubit.packages![index].nameEn ?? "",
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
                        'Arabic Name',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.packages![index].nameAr ?? "",
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
                        (widget.cubit.packages![index].price ?? 0).toString(),
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
                        widget.cubit.packages![index].type ?? "",
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.network(
                    EndPoints.imageDomain +
                        (widget.cubit.packages![index].image ?? ""),
                    height: 6.h,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                SizedBox(
                  height: 3.h,
                  child: CircleAvatar(
                    backgroundColor:
                        widget.cubit.packages![index].isActive == true
                            ? AppColors.green
                            : AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Switch(
                  value: widget.cubit.packages![index].isActive == true
                      ? true
                      : false,
                  activeColor: AppColors.green,
                  activeTrackColor: AppColors.lightGreen,
                  inactiveThumbColor: AppColors.red,
                  inactiveTrackColor: AppColors.lightGrey,
                  splashRadius: 3.0,
                  onChanged: (value) {
                    widget.cubit.switched(widget.cubit.packages![index]);
                  },
                ),
                SizedBox(
                  width: 1.w,
                ),
                AddPackageView(
                  cubit: widget.cubit,
                  title: "Update",
                  packageModel: widget.cubit.packages![index],
                ),
                SizedBox(
                  width: 2.w,
                ),
                PackageDetailsView(
                  isAdd: true,
                  cubit: widget.cubit,
                  packageId: widget.cubit.packages![index].id!,
                ),
                PackageDetailsView(
                  isAdd: false,
                  cubit: widget.cubit,
                  packageId: widget.cubit.packages![index].id!,
                ),
                SizedBox(
                  width: 2.w,
                ),
                IconButton(
                  onPressed: () {
                    widget.cubit.deletePackage(
                      id: widget.cubit.packages![index].id!,
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
