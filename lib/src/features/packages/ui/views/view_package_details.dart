import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/features/packages/cubit/packages_cubit.dart';
import 'package:jetboard/src/features/packages/data/models/package_details_model.dart';
import 'package:sizer/sizer.dart';

class ViewPackageDetails extends StatefulWidget {
  final PackagesCubit cubit;
  final PackageDetailsModel packageDetails;

  const ViewPackageDetails({
    required this.cubit,
    required this.packageDetails,
    super.key,
  });

  @override
  State<ViewPackageDetails> createState() => _ViewPackageDetailsState();
}

class _ViewPackageDetailsState extends State<ViewPackageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 15.h,
        ),
        padding: EdgeInsets.only(left: 1.w, top: 1.h),
        height: 80.h,
        width: 80.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
              color: AppColors.darkGrey.withOpacity(0.5),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: Text(
                'View Items',
                style: TextStyle(fontSize: 5.sp),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 57.w,
              child: ListView.builder(
                itemCount: widget.packageDetails.items!.length,
                itemBuilder: (context, index) {
                  return Padding(
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
                                  'Arabic Name',
                                  style: TextStyle(fontSize: 3.sp),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Arabic Name'),
                                          content: Text(
                                            widget.packageDetails.items![index]
                                                .nameAr!
                                                .toString(),
                                            style: TextStyle(fontSize: 3.sp),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    widget.packageDetails.items![index].nameAr!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 3.sp),
                                  ),
                                ),
                              ],
                            )),
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
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('English Name'),
                                        content: Text(
                                          widget.packageDetails.items![index]
                                              .nameEn!
                                              .toString(),
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  widget.packageDetails.items![index].nameEn!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 3.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            widget.cubit.deletePackageItem(
                              id: widget.packageDetails.items![index].id!,
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
