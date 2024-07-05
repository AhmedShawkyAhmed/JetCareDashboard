import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/categories/cubit/categories_cubit.dart';
import 'package:jetboard/src/features/categories/ui/views/add_category_items.dart';
import 'package:jetboard/src/features/categories/ui/views/add_category_packages.dart';
import 'package:jetboard/src/features/categories/ui/views/add_category_view.dart';
import 'package:jetboard/src/features/categories/ui/views/view_category_items.dart';
import 'package:jetboard/src/features/categories/ui/views/view_category_packages.dart';
import 'package:sizer/sizer.dart';

class CategoriesView extends StatefulWidget {
  final CategoriesCubit cubit;

  const CategoriesView({
    required this.cubit,
    super.key,
  });

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          itemCount: widget.cubit.categories!.length,
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
                        widget.cubit.categories![index].nameEn ?? "",
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
                        widget.cubit.categories![index].nameAr ?? "",
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.network(
                    EndPoints.imageDomain +
                        (widget.cubit.categories![index].image ?? ""),
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
                        widget.cubit.categories![index].isActive == true
                            ? AppColors.green
                            : AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Switch(
                  value: widget.cubit.categories![index].isActive == true
                      ? true
                      : false,
                  activeColor: AppColors.green,
                  activeTrackColor: AppColors.lightGreen,
                  inactiveThumbColor: AppColors.red,
                  inactiveTrackColor: AppColors.lightGrey,
                  splashRadius: 3.0,
                  onChanged: (value) {
                    widget.cubit.switched(widget.cubit.categories![index]);
                  },
                ),
                SizedBox(
                  width: 1.w,
                ),
                AddCategoryView(
                  cubit: widget.cubit,
                  title: "Update",
                  categoryModel: widget.cubit.categories![index],
                ),
                SizedBox(
                  width: 1.w,
                ),
                PopupMenuButton(
                  icon: const Icon(
                    Icons.add,
                    color: AppColors.grey,
                  ),
                  initialValue: selectedMenu,
                  onSelected: (SampleItem item) {
                    setState(() {
                      selectedMenu = item;
                      printSuccess(item.toString());
                      if (item == SampleItem.addPackage) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddCategoryPackages(
                              categoryId: widget.cubit.categories![index].id!,
                              cubit: widget.cubit,
                            );
                          },
                        );
                      } else if (item == SampleItem.addItems) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddCategoryItems(
                              categoryId: widget.cubit.categories![index].id!,
                              cubit: widget.cubit,
                            );
                          },
                        );
                      }
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SampleItem>>[
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.addPackage,
                      child: Text('Add Package'),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.addItems,
                      child: Text('Add Items'),
                    ),
                  ],
                ),
                PopupMenuButton(
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: AppColors.grey,
                  ),
                  initialValue: selectedMenu,
                  onSelected: (SampleItem item) {
                    setState(() {
                      selectedMenu = item;
                      printSuccess(item.toString());
                      if (item == SampleItem.viewPackage) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ViewCategoryPackages(
                              cubit: widget.cubit,
                              categoryId: widget.cubit.categories![index].id!,
                            );
                          },
                        );
                      } else if (item == SampleItem.viewItems) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ViewCategoryItems(
                              cubit: widget.cubit,
                              categoryId: widget.cubit.categories![index].id!,
                            );
                          },
                        );
                      }
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SampleItem>>[
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.viewPackage,
                      child: Text('View Package'),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.viewItems,
                      child: Text('View Items'),
                    ),
                  ],
                ),
                SizedBox(
                  width: 2.w,
                ),
                IconButton(
                  onPressed: () {
                    widget.cubit.deleteCategory(
                      id: widget.cubit.categories![index].id!,
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
