import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/category_cubit/category_cubit.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';

class ViewPackages extends StatefulWidget {
  const ViewPackages({
    super.key,
  });

  @override
  State<ViewPackages> createState() => _ViewPackagesState();
}

class _ViewPackagesState extends State<ViewPackages> {
  List<bool> isChecked = List.generate(2000, (index) => false);
  List<int> itemsId = [];

  @override
  Widget build(BuildContext context) {
    //var cubitI = ItemsCubit.get(context);
    var cubitC = CategoryCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
                'View Packages',
                style: TextStyle(fontSize: 5.sp),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 57.w,
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if(cubitC.categoryPackagesList.isEmpty){
                    return Center(
                      child: DefaultText(
                        text: "No Packages Found !",
                        fontSize: 3.sp,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: cubitC.categoryPackagesList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: 2.h, left: 3.2.w, right: 2.5.w, bottom: 1.h),
                        child: RowData(
                          rowHeight: 8.h,
                          data: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID',
                                  style: TextStyle(fontSize: 3.sp),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                  cubitC.categoryPackagesList[index].id
                                      .toString(),
                                  style: TextStyle(fontSize: 3.sp),
                                )
                              ],
                            ),
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
                                    cubitC.categoryPackagesList[index].nameEn!,
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
                                    cubitC.categoryPackagesList[index].nameAr!,
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
                                    cubitC.categoryPackagesList[index].price
                                        .toString(),
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
                                    cubitC.categoryPackagesList[index].type!,
                                    style: TextStyle(fontSize: 3.sp),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubitC.deleteCategoryPackages(
                                    type: "package",
                                    packagesItemsData:
                                        cubitC.categoryPackagesList[index],
                                    afterSuccess: () {
                                      setState(() {});
                                    });
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
