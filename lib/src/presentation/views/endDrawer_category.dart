import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/network/requests/category_request.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/category_cubit/category_cubit.dart';
import '../../business_logic/global_cubit/global_cubit.dart';
import '../../constants/constants_methods.dart';
import '../../constants/constants_variables.dart';
import '../../data/models/packages_model.dart';
import '../styles/app_colors.dart';
import '../widgets/default_app_button.dart';
import '../widgets/default_text_field.dart';

class EndDrawerWidgetCategory extends StatefulWidget {
  EndDrawerWidgetCategory({
    super.key,
    this.endDrawerWidth,
    this.heightBackButton,
    this.widthBackButton,
    this.fontTitle,
    this.fontAllTextField,
    this.heightButton,
    this.widthButton,
    this.fontButton,
    this.index,
    this.packagesModel,
    required this.isEdit,
  });

  double? endDrawerWidth;
  double? heightBackButton, widthBackButton, fontTitle, fontAllTextField;
  double? heightButton, widthButton, fontButton;
  bool isEdit;
  PackagesModel? packagesModel;
  int? index;

  @override
  State<EndDrawerWidgetCategory> createState() =>
      _EndDrawerWidgetCategoryState();
}

class _EndDrawerWidgetCategoryState extends State<EndDrawerWidgetCategory> {
  TextEditingController nameEn = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController descriptionEn = TextEditingController();
  TextEditingController descriptionAr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      nameEn.text = widget.packagesModel?.nameEn ?? "";
      descriptionEn.text = widget.packagesModel?.descriptionEn ?? "";
      nameAr.text = widget.packagesModel?.nameAr ?? "";
      descriptionAr.text = widget.packagesModel?.descriptionAr ?? "";
      imageApp = widget.packagesModel?.image ?? "";
      printSuccess(widget.packagesModel!.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = GlobalCubit.get(context);
    var cubitC = CategoryCubit.get(context);
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: Container(
            width: widget.endDrawerWidth ?? 25.w,
            height: 100.h,
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.only( left: 2.w, top: 3.h),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 3.w),
                            child: InkWell(
                              onTap: (() {
                                Navigator.pop(context);
                                cubit.isShadowE();
                              }),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width == 600 ? 1.5.w : 1.h),
                                alignment: Alignment.center,
                                height: widget.heightBackButton ?? 4.h,
                                width: widget.widthBackButton ?? 2.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        AppColors.green,
                                        AppColors.lightgreen,
                                      ]),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            cubit.isedit ? 'Update Package' : 'Add New Package',
                            style:
                                TextStyle(fontSize: widget.fontTitle ?? 6.sp),
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 5.h, left: 3.w, right: 3.w),
                        child: DefaultTextField(
                          validator: nameAr.text,
                          password: false,
                          controller: nameAr,
                          height: 7.h,
                          fontSize: widget.fontAllTextField ?? 3.sp,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'Arabic Name',
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                        child: DefaultTextField(
                          validator: nameEn.text,
                          password: false,
                          controller: nameEn,
                          height: 7.h,
                          fontSize: widget.fontAllTextField ?? 3.sp,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'English Name',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                        child: SizedBox(
                          height: 20.h,
                          child: DefaultTextField(
                            validator: descriptionAr.text,
                            password: false,
                            controller: descriptionAr,
                            height: 20.h,
                            keyboardType: TextInputType.multiline,
                            fontSize: widget.fontAllTextField ?? 3.sp,
                            haveShadow: true,
                            spreadRadius: 2,
                            blurRadius: 2,
                            maxLine: 7,
                            collapsed: true,
                            color: AppColors.white,
                            shadowColor: AppColors.black.withOpacity(0.05),
                            hintText: 'Arabic Description',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                        child: DefaultTextField(
                          validator: descriptionEn.text,
                          password: false,
                          controller: descriptionEn,
                          height: 20.h,
                          keyboardType: TextInputType.multiline,
                          fontSize: widget.fontAllTextField ?? 3.sp,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          maxLine: 7,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'English Description',
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                          child: Container(
                            height: 20.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.grey),
                                borderRadius: BorderRadius.circular(20)),
                            child: cubit.isedit
                                ? Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: imageApp == null
                                              ? cubitC.fileResult == null
                                                  ? Container()
                                                  : Image.memory(
                                                      cubitC.fileResult!.files
                                                          .first.bytes!,
                                                      fit: BoxFit.fitWidth,
                                                      width: 100.w,
                                                    )
                                              : Image.network(
                                                  imageDomain + imageApp!,
                                                  fit: BoxFit.fitWidth,
                                                  width: 100.w,
                                                )),
                                      Container(
                                        height: 4.h,
                                        width: 3.w,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            color: AppColors.green),
                                        child: IconButton(
                                            onPressed: () {
                                              cubitC.pickImage();
                                              imageApp = null;
                                              printSuccess(
                                                  cubitC.fileResult.toString());
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: AppColors.white,
                                            )),
                                      )
                                    ],
                                  )
                                : cubitC.fileResult == null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.image),
                                          TextButton(
                                              onPressed: () {
                                                cubitC.pickImage();
                                              },
                                              child: const Text('Select Image'))
                                        ],
                                      )
                                    : Stack(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.memory(
                                                cubitC.fileResult!.files.first
                                                    .bytes!,
                                                fit: BoxFit.fitWidth,
                                                width: 100.w,
                                              )),
                                          Container(
                                            height: 4.h,
                                            width: 3.w,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                                color: AppColors.green),
                                            child: IconButton(
                                                onPressed: () {
                                                  cubitC.pickImage();
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: AppColors.white,
                                                )),
                                          )
                                        ],
                                      ),
                          )),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 3.w, right: 3.w, top: 5.h),
                        child: Container(
                          alignment: Alignment.center,
                          child: DefaultAppButton(
                            title: cubit.isedit ? 'Update' : 'Add',
                            radius: 10,
                            width: widget.widthButton ?? 8.w,
                            height: widget.heightButton ?? 5.h,
                            fontSize: widget.fontButton ?? 4.sp,
                            onTap: cubit.isedit
                                ? () {
                                    cubitC.updateCategories(
                                      index: widget.index!,
                                      categoryRequest: CategoryRequest(
                                        id: widget.packagesModel!.id,
                                        nameEn: nameEn.text,
                                        descriptionEn: descriptionEn.text,
                                        nameAr: nameAr.text,
                                        descriptionAr: descriptionAr.text,
                                      ),
                                    );
                                    printSuccess(
                                        widget.packagesModel!.id.toString());
                                    nameEn.clear();
                                    descriptionEn.clear();
                                    nameAr.clear();
                                    descriptionAr.clear();
                                    cubitC.fileResult = null;
                                    Navigator.pop(context);
                                  }
                                : () {
                                    var formdata = formKey.currentState;
                                    if (formdata!.validate()) {
                                      cubitC.addCategories(
                                          categoryRequest: CategoryRequest(
                                        nameEn: nameEn.text,
                                        descriptionEn: descriptionEn.text,
                                        nameAr: nameAr.text,
                                        descriptionAr: descriptionAr.text,
                                      ));
                                      nameEn.clear();
                                      descriptionEn.clear();
                                      nameAr.clear();
                                      descriptionAr.clear();
                                      cubitC.fileResult = null;
                                      Navigator.pop(context);
                                    } else {
                                      printResponse('not valid');
                                    }
                                  },
                            haveShadow: false,
                            gradientColors: const [
                              AppColors.green,
                              AppColors.lightgreen,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
