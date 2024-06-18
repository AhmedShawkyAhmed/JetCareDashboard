import 'package:flutter/material.dart';
import 'package:jetboard/src/business_logic/category_cubit/category_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:sizer/sizer.dart';

import 'package:jetboard/src/core/utils/shared_methods.dart';
import '../../data/network/requests/category_request.dart';

class AddCategoryItems extends StatefulWidget {
  final int categoryId;

  const AddCategoryItems({
    super.key,
    required this.categoryId,
  });

  @override
  State<AddCategoryItems> createState() => _AddCategoryItemsState();
}

class _AddCategoryItemsState extends State<AddCategoryItems> {
  List<bool> isChecked = List.generate(2000, (index) => false);
  List<int> itemsId = [];

  @override
  Widget build(BuildContext context) {
    var cubitG = GlobalCubit.get(context);
    var cubitC = CategoryCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
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
                'Add Items',
                style: TextStyle(fontSize: 5.sp),
              ),
            ),
            SizedBox(
              height: 61.h,
              width: 60.w,
              child: ListView.builder(
                itemCount: cubitG.itemListForPackages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 2.h, left: 3.2.w, right: 1.w, bottom: 1.h),
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
                              cubitG.itemListForPackages[index].id.toString(),
                              style: TextStyle(fontSize: 3.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'NameEn',
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
                                          title: const Text('Message'),
                                          content: Text(
                                            cubitG.itemListForPackages[index]
                                                .nameEn
                                                .toString(),
                                            style: TextStyle(fontSize: 3.sp),
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  cubitG.itemListForPackages[index].nameEn!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 3.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
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
                                        title: const Text('Message'),
                                        content: Text(
                                          cubitG.itemListForPackages[index]
                                              .nameAr
                                              .toString(),
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  cubitG.itemListForPackages[index].nameAr!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 3.sp),
                                ),
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
                                'DescriptionEn',
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
                                        title: const Text('Message'),
                                        content: Text(
                                          cubitG.itemListForPackages[index]
                                              .descriptionEn
                                              .toString(),
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  cubitG.itemListForPackages[index]
                                      .descriptionEn!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 3.sp),
                                ),
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
                                cubitG.itemListForPackages[index].price
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
                                cubitG.itemListForPackages[index].unit!,
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
                                cubitG.itemListForPackages[index].type!,
                                style: TextStyle(fontSize: 3.sp),
                              ),
                            ],
                          ),
                        ),
                        Checkbox(
                          value: itemsId.contains(
                                  cubitG.itemListForPackages[index].id)
                              ? true
                              : isChecked[index],
                          onChanged: (bool? value) {
                            setState(
                              () {
                                isChecked[index] = value!;
                                if (isChecked[index]) {
                                  itemsId.add(
                                      cubitG.itemListForPackages[index].id!);
                                } else {
                                  itemsId.remove(
                                      cubitG.itemListForPackages[index].id);
                                }
                                printResponse(itemsId.join(' - ').toString());
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
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
                  cubitC.addCategoryItems(
                    categoryRequest: CategoryRequest(
                      id: widget.categoryId,
                      items: itemsId,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
