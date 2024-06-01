import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/data/network/requests/category_request.dart';
import 'package:jetboard/src/presentation/views/add_category_items.dart';
import 'package:jetboard/src/presentation/views/add_packages.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/indicator_view.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/category_cubit/category_cubit.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../core/constants/constants_variables.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
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
  TextEditingController nameEn = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController descriptionEn = TextEditingController();
  TextEditingController descriptionAr = TextEditingController();
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
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
                      fontSize: 3.sp,
                      color: AppColors.white,
                      bottom: 0.5.h,
                      hintText: 'Name',
                      spreadRadius: 2,
                      blurRadius: 2,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      haveShadow: true,
                      controller: search,
                      onChange: (value) {
                        if (value == "") {
                          CategoryCubit.get(context).getCategories();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          CategoryCubit.get(context)
                              .getCategories(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    const Spacer(),
                    DefaultAppButton(
                      width: 8.w,
                      height: 5.h,
                      offset: const Offset(0, 0),
                      spreadRadius: 2,
                      blurRadius: 2,
                      radius: 10,
                      gradientColors: const [
                        AppColors.green,
                        AppColors.lightGreen,
                      ],
                      fontSize: 4.sp,
                      haveShadow: false,
                      title: "Add",
                      onTap: () {
                        setState(() {
                          GlobalCubit.get(context).isEdit = false;
                          nameEn.clear();
                          descriptionEn.clear();
                          nameAr.clear();
                          descriptionAr.clear();
                          imageApp = null;
                        });
                        showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppColors.white,
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    const DefaultText(
                                      text: "Add New Category",
                                      align: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 2.h,
                                        left: 3.w,
                                        right: 3.w,
                                      ),
                                      child: DefaultTextField(
                                        validator: nameAr.text,
                                        password: false,
                                        controller: nameAr,
                                        height: 5.h,
                                        fontSize: 3.sp,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'Arabic Name',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 2.h,
                                        left: 3.w,
                                        right: 3.w,
                                      ),
                                      child: DefaultTextField(
                                        validator: nameEn.text,
                                        password: false,
                                        controller: nameEn,
                                        height: 5.h,
                                        fontSize: 3.sp,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'English Name',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 2.h,
                                        left: 3.w,
                                        right: 3.w,
                                      ),
                                      child: SizedBox(
                                        height: 20.h,
                                        child: DefaultTextField(
                                          validator: descriptionAr.text,
                                          password: false,
                                          controller: descriptionAr,
                                          height: 20.h,
                                          keyboardType: TextInputType.multiline,
                                          fontSize: 3.sp,
                                          haveShadow: true,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          maxLine: 7,
                                          collapsed: true,
                                          color: AppColors.white,
                                          shadowColor:
                                              AppColors.black.withOpacity(0.05),
                                          hintText: 'Arabic Description',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 2.h,
                                        left: 3.w,
                                        right: 3.w,
                                      ),
                                      child: DefaultTextField(
                                        validator: descriptionEn.text,
                                        password: false,
                                        controller: descriptionEn,
                                        height: 20.h,
                                        keyboardType: TextInputType.multiline,
                                        fontSize: 3.sp,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        maxLine: 7,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'English Description',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 2.h,
                                        left: 3.w,
                                        right: 3.w,
                                      ),
                                      child: BlocBuilder<CategoryCubit,
                                          CategoryState>(
                                        builder: (context, state) {
                                          return Container(
                                            height: 20.h,
                                            width: 20.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: GlobalCubit.get(context)
                                                    .isEdit
                                                ? Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: imageApp == null
                                                            ? CategoryCubit.get(
                                                                            context)
                                                                        .fileResult ==
                                                                    null
                                                                ? Container()
                                                                : Image.memory(
                                                                    CategoryCubit.get(
                                                                            context)
                                                                        .fileResult!
                                                                        .files
                                                                        .first
                                                                        .bytes!,
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    width:
                                                                        100.w,
                                                                  )
                                                            : Image.network(
                                                                EndPoints
                                                                        .imageDomain +
                                                                    imageApp!,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                                width: 100.w,
                                                              ),
                                                      ),
                                                      Container(
                                                        height: 4.h,
                                                        width: 3.w,
                                                        decoration:
                                                            const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20),
                                                                ),
                                                                color: AppColors
                                                                    .green),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            CategoryCubit.get(
                                                                    context)
                                                                .pickImage();
                                                            imageApp = null;
                                                            printSuccess(
                                                                CategoryCubit.get(
                                                                        context)
                                                                    .fileResult
                                                                    .toString());
                                                          },
                                                          icon: const Icon(
                                                            Icons.edit,
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : CategoryCubit.get(context)
                                                            .fileResult ==
                                                        null
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                              Icons.image),
                                                          TextButton(
                                                            onPressed: () {
                                                              CategoryCubit.get(
                                                                      context)
                                                                  .pickImage();
                                                            },
                                                            child: const Text(
                                                                'Select Image'),
                                                          )
                                                        ],
                                                      )
                                                    : Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Image.memory(
                                                              CategoryCubit.get(
                                                                      context)
                                                                  .fileResult!
                                                                  .files
                                                                  .first
                                                                  .bytes!,
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                              width: 100.w,
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 4.h,
                                                            width: 3.w,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20),
                                                                    ),
                                                                    color: AppColors
                                                                        .green),
                                                            child: IconButton(
                                                              onPressed: () {
                                                                CategoryCubit.get(
                                                                        context)
                                                                    .pickImage();
                                                              },
                                                              icon: const Icon(
                                                                Icons.edit,
                                                                color: AppColors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: <Widget>[
                                DefaultAppButton(
                                  title: "Save",
                                  onTap: () {
                                    CategoryCubit.get(context).addCategories(
                                      categoryRequest: CategoryRequest(
                                        nameEn: nameEn.text,
                                        descriptionEn: descriptionEn.text,
                                        nameAr: nameAr.text,
                                        descriptionAr: descriptionAr.text,
                                      ),
                                    );
                                    nameEn.clear();
                                    descriptionEn.clear();
                                    nameAr.clear();
                                    descriptionAr.clear();
                                    CategoryCubit.get(context).fileResult =
                                        null;
                                    Navigator.pop(context);
                                  },
                                  width: 10.w,
                                  height: 4.h,
                                  fontSize: 3.sp,
                                  textColor: AppColors.white,
                                  buttonColor: AppColors.primary,
                                  isGradient: false,
                                  radius: 10,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DefaultAppButton(
                                  title: "Cancel",
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  width: 10.w,
                                  height: 4.h,
                                  fontSize: 3.sp,
                                  textColor: AppColors.mainColor,
                                  buttonColor: AppColors.lightGrey,
                                  isGradient: false,
                                  radius: 10,
                                ),
                              ],
                            );
                          },
                        );
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
                              top: 0.5.h,
                              left: 3.2.w,
                              right: 2.5,
                            ),
                            child: LoadingView(
                              width: 90.w,
                              height: 5.h,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (CategoryCubit.get(context)
                      .getCategoryResponse!
                      .categoryModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Categories Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount: CategoryCubit.get(context).listCount,
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
                                      CategoryCubit.get(context)
                                          .categoryList[index]
                                          .nameEn
                                          .toString(),
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
                                      CategoryCubit.get(context)
                                          .categoryList[index]
                                          .nameAr
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  EndPoints.imageDomain +
                                      CategoryCubit.get(context)
                                          .categoryList[index]
                                          .image,
                                  height: 6.h,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor: CategoryCubit.get(context)
                                              .categoryList[index]
                                              .active ==
                                          1
                                      ? AppColors.green
                                      : AppColors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Switch(
                                value: CategoryCubit.get(context)
                                            .categoryList[index]
                                            .active ==
                                        1
                                    ? true
                                    : false,
                                activeColor: AppColors.green,
                                activeTrackColor: AppColors.lightGreen,
                                inactiveThumbColor: AppColors.red,
                                inactiveTrackColor: AppColors.lightGrey,
                                splashRadius: 3.0,
                                onChanged: (value) {
                                  CategoryCubit.get(context).switched(index);
                                  CategoryCubit.get(context)
                                      .updateCategoriesStatus(
                                    index: index,
                                    categoryRequest: CategoryRequest(
                                      id: CategoryCubit.get(context)
                                          .categoryList[index]
                                          .id,
                                      active: CategoryCubit.get(context)
                                              .categoryList[index]
                                              .active
                                              .isOdd
                                          ? 1
                                          : 0,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    GlobalCubit.get(context).isEdit = true;
                                    nameEn.text = CategoryCubit.get(context)
                                        .categoryList[index]
                                        .nameEn;
                                    descriptionEn.text =
                                        CategoryCubit.get(context)
                                            .categoryList[index]
                                            .descriptionEn;
                                    nameAr.text = CategoryCubit.get(context)
                                        .categoryList[index]
                                        .nameAr;
                                    descriptionAr.text =
                                        CategoryCubit.get(context)
                                            .categoryList[index]
                                            .descriptionAr;
                                    imageApp = CategoryCubit.get(context)
                                        .categoryList[index]
                                        .image;
                                  });
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: AppColors.white,
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              const DefaultText(
                                                  text: "Update Category",
                                                  align: TextAlign.center),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2.h,
                                                    left: 3.w,
                                                    right: 3.w),
                                                child: DefaultTextField(
                                                  validator: nameAr.text,
                                                  password: false,
                                                  controller: nameAr,
                                                  height: 5.h,
                                                  fontSize: 3.sp,
                                                  haveShadow: true,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  color: AppColors.white,
                                                  shadowColor: AppColors.black
                                                      .withOpacity(0.05),
                                                  hintText: 'Arabic Name',
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2.h,
                                                    left: 3.w,
                                                    right: 3.w),
                                                child: DefaultTextField(
                                                  validator: nameEn.text,
                                                  password: false,
                                                  controller: nameEn,
                                                  height: 5.h,
                                                  fontSize: 3.sp,
                                                  haveShadow: true,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  color: AppColors.white,
                                                  shadowColor: AppColors.black
                                                      .withOpacity(0.05),
                                                  hintText: 'English Name',
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2.h,
                                                    left: 3.w,
                                                    right: 3.w),
                                                child: SizedBox(
                                                  height: 20.h,
                                                  child: DefaultTextField(
                                                    validator:
                                                        descriptionAr.text,
                                                    password: false,
                                                    controller: descriptionAr,
                                                    height: 20.h,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    fontSize: 3.sp,
                                                    haveShadow: true,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    maxLine: 7,
                                                    collapsed: true,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors.black
                                                        .withOpacity(0.05),
                                                    hintText:
                                                        'Arabic Description',
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2.h,
                                                    left: 3.w,
                                                    right: 3.w),
                                                child: DefaultTextField(
                                                  validator: descriptionEn.text,
                                                  password: false,
                                                  controller: descriptionEn,
                                                  height: 20.h,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  fontSize: 3.sp,
                                                  haveShadow: true,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  maxLine: 7,
                                                  color: AppColors.white,
                                                  shadowColor: AppColors.black
                                                      .withOpacity(0.05),
                                                  hintText:
                                                      'English Description',
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 2.h,
                                                  left: 3.w,
                                                  right: 3.w,
                                                ),
                                                child: BlocBuilder<
                                                    CategoryCubit,
                                                    CategoryState>(
                                                  builder: (context, state) {
                                                    return Container(
                                                      height: 20.h,
                                                      width: 20.w,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: AppColors.grey,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: GlobalCubit.get(
                                                                  context)
                                                              .isEdit
                                                          ? Stack(
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  child: imageApp ==
                                                                          null
                                                                      ? CategoryCubit.get(context).fileResult ==
                                                                              null
                                                                          ? Container()
                                                                          : Image
                                                                              .memory(
                                                                              CategoryCubit.get(context).fileResult!.files.first.bytes!,
                                                                              fit: BoxFit.fitWidth,
                                                                              width: 100.w,
                                                                            )
                                                                      : Image
                                                                          .network(
                                                                          EndPoints.imageDomain +
                                                                              imageApp!,
                                                                          fit: BoxFit
                                                                              .fitWidth,
                                                                          width:
                                                                              100.w,
                                                                        ),
                                                                ),
                                                                Container(
                                                                  height: 4.h,
                                                                  width: 3.w,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20),
                                                                    ),
                                                                    color: AppColors
                                                                        .green,
                                                                  ),
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      CategoryCubit.get(
                                                                              context)
                                                                          .pickImage();
                                                                      imageApp =
                                                                          null;
                                                                      printSuccess(CategoryCubit.get(
                                                                              context)
                                                                          .fileResult
                                                                          .toString());
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: AppColors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : CategoryCubit.get(
                                                                          context)
                                                                      .fileResult ==
                                                                  null
                                                              ? Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Icon(Icons
                                                                        .image),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        CategoryCubit.get(context)
                                                                            .pickImage();
                                                                      },
                                                                      child: const Text(
                                                                          'Select Image'),
                                                                    )
                                                                  ],
                                                                )
                                                              : Stack(
                                                                  children: [
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20),
                                                                        child: Image
                                                                            .memory(
                                                                          CategoryCubit.get(context)
                                                                              .fileResult!
                                                                              .files
                                                                              .first
                                                                              .bytes!,
                                                                          fit: BoxFit
                                                                              .fitWidth,
                                                                          width:
                                                                              100.w,
                                                                        )),
                                                                    Container(
                                                                      height:
                                                                          4.h,
                                                                      width:
                                                                          3.w,
                                                                      decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(20),
                                                                              bottomRight: Radius.circular(20)),
                                                                          color: AppColors.green),
                                                                      child:
                                                                          IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          CategoryCubit.get(context)
                                                                              .pickImage();
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .edit,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        actions: <Widget>[
                                          DefaultAppButton(
                                            title: "Save",
                                            onTap: () {
                                              CategoryCubit.get(context)
                                                  .updateCategories(
                                                index: index,
                                                categoryRequest:
                                                    CategoryRequest(
                                                  id: CategoryCubit.get(context)
                                                      .categoryList[index]
                                                      .id,
                                                  nameEn: nameEn.text,
                                                  descriptionEn:
                                                      descriptionEn.text,
                                                  nameAr: nameAr.text,
                                                  descriptionAr:
                                                      descriptionAr.text,
                                                ),
                                              );
                                              nameEn.clear();
                                              descriptionEn.clear();
                                              nameAr.clear();
                                              descriptionAr.clear();
                                              CategoryCubit.get(context)
                                                  .fileResult = null;
                                              Navigator.pop(context);
                                            },
                                            width: 10.w,
                                            height: 4.h,
                                            fontSize: 3.sp,
                                            textColor: AppColors.white,
                                            buttonColor: AppColors.primary,
                                            isGradient: false,
                                            radius: 10,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          DefaultAppButton(
                                            title: "Cancel",
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            width: 10.w,
                                            height: 4.h,
                                            fontSize: 3.sp,
                                            textColor: AppColors.mainColor,
                                            buttonColor: AppColors.lightGrey,
                                            isGradient: false,
                                            radius: 10,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColors.grey,
                                ),
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
                                  setState(
                                    () {
                                      selectedMenu = item;
                                      printSuccess(item.toString());
                                      if (item == SampleItem.addPackage) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AddPackages(
                                              packageId:
                                                  CategoryCubit.get(context)
                                                      .categoryList[index]
                                                      .id,
                                            );
                                          },
                                        );
                                      } else if (item == SampleItem.addItems) {
                                        IndicatorView.showIndicator(context);
                                        GlobalCubit.get(context)
                                            .getItemsForPackages(
                                                afterSuccess: () {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AddCategoryItems(
                                                categoryId:
                                                    CategoryCubit.get(context)
                                                        .categoryList[index]
                                                        .id,
                                              );
                                            },
                                          );
                                        });
                                      }
                                    },
                                  );
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
                                  setState(
                                    () {
                                      selectedMenu = item;
                                      printSuccess(item.toString());
                                      if (item == SampleItem.viewPackage) {
                                        CategoryCubit.get(context)
                                            .getCategoriesPackages(
                                          id: CategoryCubit.get(context)
                                              .categoryList[index]
                                              .id,
                                          afterSucccess: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const ViewPackages();
                                              },
                                            );
                                          },
                                        );
                                      } else if (item == SampleItem.viewItems) {
                                        CategoryCubit.get(context)
                                            .getCategoriesItems(
                                          id: CategoryCubit.get(context)
                                              .categoryList[index]
                                              .id,
                                          afterSucccess: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const ViewCategoryItems();
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                  );
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
                                    CategoryCubit.get(context).deleteCategories(
                                      packagesModel: CategoryCubit.get(context)
                                          .categoryList[index],
                                    );
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
