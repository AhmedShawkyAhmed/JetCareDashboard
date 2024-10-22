import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/features/categories/cubit/categories_cubit.dart';
import 'package:sizer/sizer.dart';

class ViewCategoryItems extends StatefulWidget {
  final CategoriesCubit cubit;
  final int categoryId;

  const ViewCategoryItems({
    required this.cubit,
    required this.categoryId,
    super.key,
  });

  @override
  State<ViewCategoryItems> createState() => _ViewCategoryItemsState();
}

class _ViewCategoryItemsState extends State<ViewCategoryItems> {

  @override
  void initState() {
    widget.cubit.getCategoryDetails(id: widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
                'View Items',
                style: TextStyle(fontSize: 5.sp),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 57.w,
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (widget.cubit.categoryDetails!.items == null) {
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
                  } else if (widget.cubit.categoryDetails!.items!.isEmpty) {
                    return Center(
                      child: DefaultText(
                        text: "No Items Found !",
                        fontSize: 3.sp,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: widget.cubit.categoryDetails!.items!.length,
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
                                  widget.cubit.categoryDetails!.items![index].id
                                      .toString(),
                                  style: TextStyle(fontSize: 3.sp),
                                )
                              ],
                            ),
                            SizedBox(width: 1.w),
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
                                            title: const Text('NameEn'),
                                            content: Text(
                                              widget.cubit.categoryDetails!
                                                  .items![index].nameEn!
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 3.sp,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      widget.cubit.categoryDetails!
                                          .items![index].nameEn!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
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
                                      'NameAr',
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
                                              title: const Text('NameAr'),
                                              content: Text(
                                                widget.cubit.categoryDetails!
                                                    .items![index].nameAr!
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 3.sp,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        widget.cubit.categoryDetails!
                                            .items![index].nameAr!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ),
                                  ],
                                )),
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
                                    widget.cubit.categoryDetails!.items![index]
                                        .price
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
                                    'Unit',
                                    style: TextStyle(fontSize: 3.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    widget.cubit.categoryDetails!.items![index]
                                        .unit!,
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
                                    widget.cubit.categoryDetails!.items![index]
                                        .type!.name,
                                    style: TextStyle(fontSize: 3.sp),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                widget.cubit.deleteCategoryItem(
                                  id: widget
                                      .cubit.categoryDetails!.items![index].id!,
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
