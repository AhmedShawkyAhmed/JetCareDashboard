import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/packages_cubit/packages_cubit.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

import 'package:jetboard/src/core/utils/shared_methods.dart';
import '../../core/constants/constants_variables.dart';
import '../../data/models/packages_model.dart';
import '../../data/network/requests/packages_request.dart';

class EndDrawerWidgetPackages extends StatefulWidget {
  EndDrawerWidgetPackages({super.key, 
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
  State<EndDrawerWidgetPackages> createState() =>
      _EndDrawerWidgetPackagesState();
}

class _EndDrawerWidgetPackagesState extends State<EndDrawerWidgetPackages> {
  TextEditingController nameEn = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController descriptionEn = TextEditingController();
  TextEditingController descriptionAr = TextEditingController();
  TextEditingController price = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      nameEn.text = widget.packagesModel?.nameEn ?? "";
      descriptionEn.text = widget.packagesModel?.descriptionEn ?? "";
      nameAr.text = widget.packagesModel?.nameAr ?? "";
      descriptionAr.text = widget.packagesModel?.descriptionAr ?? "";
      price.text = widget.packagesModel?.price.toString() ?? "";
      dropItemsItem = widget.packagesModel?.type ?? "";
      imageApp = widget.packagesModel?.image ?? "";
      printSuccess(widget.packagesModel!.image);
    }
  }
  
  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
      var cubit = GlobalCubit.get(context);
      var cubitP = PackagesCubit.get(context);
      return BlocBuilder<PackagesCubit, PackagesState>(
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
                padding: EdgeInsets.only(left: 2.w, top: 3.h),
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
                              child: GestureDetector(
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
                                          AppColors.lightGreen,
                                        ]),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              cubit.isEdit ? 'Update Package' : 'Add New Package',
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
                          child: DefaultTextField(
                            validator: price.text,
                            password: false,
                            height: 7.h,
                            fontSize: widget.fontAllTextField ?? 4.sp,
                            controller: price,
                            haveShadow: true,
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: AppColors.white,
                            shadowColor: AppColors.black.withOpacity(0.05),
                            hintText: 'Price',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                          child: DefaultDropdown<String>(
                            hint: "Category",
                            showSearchBox: true,
                            selectedItem: dropItemsItem == ''
                              ? cubitP.categoryTypes.last
                              : dropItemsItem,
                            items: cubitP.categoryTypes,
                            onChanged: (val) {
                              setState(() {
                                dropItemsItem = val!;
                              });
                            },
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
                              child: cubit.isEdit
                                  ? Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: imageApp == null
                                                ? cubitP.fileResult == null
                                                    ? Container()
                                                    : Image.memory(
                                                        cubitP.fileResult!.files
                                                            .first.bytes!,
                                                        fit: BoxFit.fitWidth,
                                                        width: 100.w,
                                                      )
                                                : Image.network(
                                              EndPoints.imageDomain + imageApp!,
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
                                                cubitP.pickImage();
                                                imageApp = null;
                                                printSuccess(
                                                    cubitP.fileResult.toString());
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: AppColors.white,
                                              )),
                                        )
                                      ],
                                    )
                                  : cubitP.fileResult == null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.image),
                                            TextButton(
                                                onPressed: () {
                                                  cubitP.pickImage();
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
                                                  cubitP.fileResult!.files.first
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
                                                    cubitP.pickImage();
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
                              EdgeInsets.only(left: 3.w, right: 3.w, top: 5.h,bottom: 5.h),
                          child: Container(
                            alignment: Alignment.center,
                            child: DefaultAppButton(
                              title: cubit.isEdit ? 'Update' : 'Add',
                              radius: 10,
                              width: widget.widthButton ?? 8.w,
                              height: widget.heightButton ?? 5.h,
                              fontSize: widget.fontButton ?? 4.sp,
                              onTap: cubit.isEdit
                                ? () {

                                    cubitP.updatePackages(
                                      index: widget.index!,
                                      packagesRequest: PackagesRequest(
                                        id: widget.packagesModel!.id,
                                        nameEn: nameEn.text,
                                        descriptionEn: descriptionEn.text,
                                        nameAr: nameAr.text,
                                        descriptionAr: descriptionAr.text,
                                        price: double.parse(price.text),
                                        type: dropItemsItem == ''
                                            ? cubitP.categoryTypes.last
                                            : dropItemsItem,
                                      ),
                                    );
                                    printSuccess(widget.packagesModel!.id.toString());
                                    nameEn.clear();
                                    descriptionEn.clear();
                                    nameAr.clear();
                                    descriptionAr.clear();
                                    price.clear();
                                    cubitP.fileResult = null;
                                    dropItemsItem = '';
                                    Navigator.pop(context);
                                  }
                                : () {
                                  var formdata = formKey.currentState;
                                  if(formdata!.validate()){

                                    cubitP.addPackages(
                                      packagesRequest: PackagesRequest(
                                      nameEn: nameEn.text,
                                      descriptionEn: descriptionEn.text,
                                      nameAr: nameAr.text,
                                      descriptionAr: descriptionAr.text,
                                      price: double.parse(price.text),
                                      type: dropItemsItem,
                                    ));
                                    nameEn.clear();
                                    descriptionEn.clear();
                                    nameAr.clear();
                                    descriptionAr.clear();
                                    price.clear();
                                    cubitP.fileResult = null;
                                    dropItemsItem = '';
                                    Navigator.pop(context);
                                  }else{
                                  printResponse('not valid');
                                }
                                  },
                              haveShadow: false,
                              gradientColors: const [
                                AppColors.green,
                                AppColors.lightGreen,
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
