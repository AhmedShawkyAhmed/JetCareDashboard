import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/network/requests/category_request.dart';
import 'package:jetboard/src/presentation/views/add_category_items.dart';
import 'package:jetboard/src/presentation/views/add_packages.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/category_cubit/category_cubit.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../constants/constants_methods.dart';
import '../../../constants/constants_variables.dart';
import '../../styles/app_colors.dart';
import '../../views/endDrawer_category.dart';
import '../../views/loading_view.dart';
import '../../views/row_data.dart';
import '../../views/view_category_items.dart';
import '../../views/view_packages.dart';
import '../../widgets/default_app_button.dart';
import '../../widgets/default_text_field.dart';

class CategoryDesktop extends StatefulWidget {
  const CategoryDesktop({super.key});

  @override
  State<CategoryDesktop> createState() => _CategoryDesktopState();
}

enum SampleItem {
  addPackage,
  addItems,
  viewPackage,
  viewItems,
}

class _CategoryDesktopState extends State<CategoryDesktop> {
  TextEditingController search = TextEditingController();
  String dropdownvalue = 'Item 1';
  SampleItem? selectedMenu;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  int currentIndex = 0;
  List<bool> isChecked = List.generate(2000, (index) => false);
  List<int> itemsId = [];

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubitC = CategoryCubit.get(context);
    //var cubitP = PackagesCubit.get(context);

    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      key: scaffoldkey,
      endDrawer: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          return EndDrawerWidgetCategory(
            index: currentIndex,
            isEdit: cubit.isedit,
            packagesModel: cubitC.categoryList.isEmpty
                ? null
                : cubitC.categoryList[currentIndex],
          );
        },
      ),
      backgroundColor: AppColors.green,
      body: Container(
        height: 100.h,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextField(
                      password: false,
                      width: 25.w,
                      height: 5.h,
                      fontSize: 4.sp,
                      color: AppColors.white,
                      bottom: 0.5.h,
                      hintText: 'Name',
                      spreadRadius: 2,
                      blurRadius: 2,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      haveShadow: true,
                      controller: search,
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          cubitC.getCategories(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    const Spacer(),
                    DefaultAppButton(
                      width: 8.w,
                      height: 5.h,
                      haveShadow: true,
                      offset: const Offset(0, 0),
                      spreadRadius: 2,
                      blurRadius: 2,
                      radius: 10,
                      gradientColors: const [
                        AppColors.green,
                        AppColors.lightgreen,
                      ],
                      fontSize: 5.sp,
                      title: "Add",
                      onTap: () {
                        cubit.isedit = false;
                        scaffoldkey.currentState!.openEndDrawer();
                      },
                    )
                  ],
                ),
              ),
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (CategoryCubit.get(context)
                          .getCategoryResponse
                          ?.categoryModel ==
                      null) {
                    return Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: SizedBox(
                        height: 79.h,
                        child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.5.h, left: 3.2.w, right: 2.5),
                                  child: LoadingView(
                                    width: 90.w,
                                    height: 5.h,
                                  ),
                                )),
                      ),
                    );
                  } else if (CategoryCubit.get(context)
                      .getCategoryResponse!
                      .categoryModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Categories Yet !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount: cubitC.listCount,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              top: 2.h, left: 3.2.w, right: 2.5.w, bottom: 1.h),
                          child: RowData(
                            rowHeight: 8.h,
                            data: [
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
                                      Text(
                                        cubitC.categoryList[index].nameEn
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
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
                                      Text(
                                        cubitC.categoryList[index].nameAr
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    imageDomain +
                                        cubitC.categoryList[index].image,
                                    height: 6.h,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor:
                                      cubitC.categoryList[index].active == 1
                                          ? AppColors.green
                                          : AppColors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Switch(
                                  value: cubitC.categoryList[index].active == 1
                                      ? true
                                      : false,
                                  activeColor: AppColors.green,
                                  activeTrackColor: AppColors.lightgreen,
                                  inactiveThumbColor: AppColors.red,
                                  inactiveTrackColor: AppColors.lightGrey,
                                  splashRadius: 3.0,
                                  onChanged: (value) {
                                    cubitC.switched(index);
                                    cubitC.updateCategoriesStatus(
                                      index: index,
                                      categoryRequest: CategoryRequest(
                                        id: cubitC.categoryList[index].id,
                                        active: cubitC.categoryList[index]
                                                .active.isOdd
                                            ? 1
                                            : 0,
                                      ),
                                      //indexs: index,
                                    );
                                  }),
                              SizedBox(
                                width: 1.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    currentIndex = index;
                                    cubit.isedit = true;
                                    scaffoldkey.currentState!.openEndDrawer();
                                    printSuccess(currentIndex.toString());
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.grey,
                                  )),
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
                                            return AddPackages(
                                              packageId:
                                                  cubitC.categoryList[index].id,
                                            );
                                          });
                                    } else if (item == SampleItem.addItems) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AddCategoryItems(
                                              CategoryId:
                                                  cubitC.categoryList[index].id,
                                            );
                                          });
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
                                      cubitC.getCategoriesPackages(
                                        id: cubitC.categoryList[index].id,
                                        afterSucccess: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ViewPackages(
                                                  package: cubitC
                                                      .categoryPackagesList,
                                                  indexs: index,
                                                );
                                              });
                                        },
                                      );
                                    } else if (item == SampleItem.viewItems) {
                                      cubitC.getCategoriesItems(
                                        id: cubitC.categoryList[index].id,
                                        afterSucccess: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ViewCategoryItems(
                                                  itmes: cubitC
                                                      .categoryItemsList,
                                                  indexs: index,
                                                );
                                              });
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
                              // IconButton(
                              //     onPressed: () {
                              //       cubitC.getCategoriesPackages(
                              //         id: cubitC.categoryList[index].id,
                              //         afterSucccess: () {
                              //           showDialog(
                              //             context: context,
                              //             builder: (context) {
                              //               return ViewPackages(
                              //                 package:
                              //                     cubitC.categoryPackagesList,
                              //                 indexs: index,
                              //               );
                              //             });
                              //         },
                              //       );
                              //     },
                              //     icon: const Icon(
                              //       Icons.remove_red_eye,
                              //       color: AppColors.grey,
                              //     )),
                              SizedBox(
                                width: 2.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubitC.deleteCategories(
                                        packagesModel:
                                            cubitC.categoryList[index]);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.red,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
