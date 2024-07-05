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
import 'package:jetboard/src/features/items/cubit/items_cubit.dart';
import 'package:sizer/sizer.dart';

class AddCategoryItems extends StatefulWidget {
  final int categoryId;
  final CategoriesCubit cubit;

  const AddCategoryItems({
    super.key,
    required this.categoryId,
    required this.cubit,
  });

  @override
  State<AddCategoryItems> createState() => _AddCategoryItemsState();
}

class _AddCategoryItemsState extends State<AddCategoryItems> {
  ItemsCubit itemsCubit = ItemsCubit(instance());
  List<bool> isChecked = List.generate(2000, (index) => false);
  List<int> itemsId = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => itemsCubit..getItems(),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
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
                  'Add Items',
                  style: TextStyle(fontSize: 5.sp),
                ),
              ),
              BlocBuilder<ItemsCubit, ItemsState>(
                builder: (context, state) {
                  if (itemsCubit.items == null) {
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
                  } else if (itemsCubit.items!.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Items Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 61.h,
                    width: 60.w,
                    child: ListView.builder(
                      itemCount: itemsCubit.items!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 3.2.w,
                            right: 1.w,
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
                                    itemsCubit.items![index].id.toString(),
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
                                                title: const Text('NameEn'),
                                                content: Text(
                                                  itemsCubit
                                                      .items![index].nameEn
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        itemsCubit.items![index].nameEn!,
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
                                              title: const Text('NameAr'),
                                              content: Text(
                                                itemsCubit.items![index].nameAr
                                                    .toString(),
                                                style:
                                                    TextStyle(fontSize: 3.sp),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        itemsCubit.items![index].nameAr!,
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
                                              title:
                                                  const Text('DescriptionEn'),
                                              content: Text(
                                                itemsCubit
                                                    .items![index].descriptionEn
                                                    .toString(),
                                                style:
                                                    TextStyle(fontSize: 3.sp),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        itemsCubit.items![index].descriptionEn!,
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
                                      itemsCubit.items![index].price.toString(),
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
                                      itemsCubit.items![index].unit!,
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
                                      itemsCubit.items![index].type!.name,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Checkbox(
                                value: itemsId
                                        .contains(itemsCubit.items![index].id)
                                    ? true
                                    : isChecked[index],
                                onChanged: (bool? value) {
                                  setState(
                                    () {
                                      isChecked[index] = value!;
                                      if (isChecked[index]) {
                                        itemsId
                                            .add(itemsCubit.items![index].id!);
                                      } else {
                                        itemsId.remove(
                                            itemsCubit.items![index].id);
                                      }
                                      printResponse(
                                          itemsId.join(' - ').toString());
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
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
                    widget.cubit.addCategoryItem(
                      request: CategoryItemRequest(
                        categoryId: widget.categoryId,
                        itemIds: itemsId,
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
