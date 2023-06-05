import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/category_cubit/category_cubit.dart';
import '../styles/app_colors.dart';

class ViewCategoryItems extends StatefulWidget {
  const ViewCategoryItems({
    super.key,
  });

  @override
  State<ViewCategoryItems> createState() => _ViewCategoryItemsState();
}

class _ViewCategoryItemsState extends State<ViewCategoryItems> {
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
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15)),
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
              icon: const Icon(Icons.arrow_back_ios),
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
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if(cubitC.categoryItemsList.isEmpty){
                    return Center(
                      child: DefaultText(
                        text: "No Items Found !",
                        fontSize: 3.sp,
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: cubitC.categoryItemsList.length,
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
                                    cubitC.categoryItemsList[index].id
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
                                                  title: const Text('NameAr'),
                                                  content: Text(
                                                    cubitC
                                                        .categoryItemsList[
                                                    index]
                                                        .nameEn!
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 3.sp),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Text(
                                          cubitC
                                              .categoryItemsList[index].nameEn!,
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
                                                    cubitC
                                                        .categoryItemsList[
                                                    index]
                                                        .nameAr!
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 3.sp),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Text(
                                          cubitC
                                              .categoryItemsList[index].nameAr!,
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
                                        cubitC.categoryItemsList[index].price
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
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
                                        cubitC.categoryItemsList[index].unit!,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
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
                                        cubitC.categoryItemsList[index].type!,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              IconButton(
                                onPressed: () {
                                  cubitC.deleteCategoryPackages(
                                      type: "item",
                                      packagesItemsData:
                                      cubitC.categoryItemsList[index],
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
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
