import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/categories/cubit/categories_cubit.dart';
import 'package:jetboard/src/features/categories/data/requests/category_item_request.dart';
import 'package:jetboard/src/features/packages/cubit/packages_cubit.dart';
import 'package:sizer/sizer.dart';

class AddCategoryPackages extends StatefulWidget {
  final int categoryId;
  final CategoriesCubit cubit;

  const AddCategoryPackages({
    super.key,
    required this.categoryId,
    required this.cubit,
  });

  @override
  State<AddCategoryPackages> createState() => _AddCategoryPackagesState();
}

class _AddCategoryPackagesState extends State<AddCategoryPackages> {
  PackagesCubit packagesCubit = PackagesCubit(instance());
  List<bool> isChecked = List.generate(2000, (index) => false);
  List<int> packageIds = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => packagesCubit..getPackages(),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
          padding: EdgeInsets.only(left: 1.w, top: 1.h),
          height: 80.h,
          width: 80.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  NavigationService.pop();
                },
                icon: const Icon(Icons.close),
                color: AppColors.darkGrey.withOpacity(0.5),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Text(
                  'Add Packages',
                  style: TextStyle(fontSize: 5.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              BlocBuilder<PackagesCubit, PackagesState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 55.h,
                    width: 57.w,
                    child: BlocBuilder<PackagesCubit, PackagesState>(
                      builder: (context, state) {
                        if (packagesCubit.packages == null) {
                          return SizedBox(
                            height: 79.h,
                            child: ListView.builder(
                              itemCount: 6,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                  top: 1.h,
                                  left: 2.8.w,
                                  right: 37,
                                ),
                                child: LoadingView(
                                  width: 90.w,
                                  height: 5.h,
                                ),
                              ),
                            ),
                          );
                        } else if (packagesCubit.packages!.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(top: 40.h),
                            child: DefaultText(
                              text: "No Packages Found !",
                              fontSize: 5.sp,
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: packagesCubit.packages!.length,
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        packagesCubit.packages![index].id
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'English Name',
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          packagesCubit
                                                  .packages![index].nameEn ??
                                              "",
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'NameAr',
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          packagesCubit
                                                  .packages![index].nameAr ??
                                              "",
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Price',
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          packagesCubit.packages![index].price
                                              .toString(),
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Type',
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          packagesCubit.packages![index].type ??
                                              "",
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Checkbox(
                                    value: packageIds.contains(
                                            packagesCubit.packages![index].id)
                                        ? true
                                        : isChecked[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked[index] = value!;
                                        if (isChecked[index]) {
                                          packageIds.add(packagesCubit
                                              .packages![index].id!);
                                        } else {
                                          packageIds.remove(packagesCubit
                                              .packages![index].id);
                                        }
                                        printResponse(
                                            packageIds.join(' - ').toString());
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w, top: 1.h),
                child: DefaultAppButton(
                  width: 6.w,
                  height: 4.h,
                  haveShadow: true,
                  offset: const Offset(0, 0),
                  spreadRadius: 2,
                  blurRadius: 2,
                  radius: 10,
                  gradientColors: const [
                    AppColors.green,
                    AppColors.lightGreen,
                  ],
                  fontSize: 4.sp,
                  title: 'Add',
                  onTap: () {
                    widget.cubit.addCategoryPackage(
                      request: CategoryItemRequest(
                        categoryId: widget.categoryId,
                        packageIds: packageIds,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
