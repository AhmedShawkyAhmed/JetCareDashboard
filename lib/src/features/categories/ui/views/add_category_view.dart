import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/features/categories/cubit/categories_cubit.dart';
import 'package:jetboard/src/features/categories/data/models/category_model.dart';
import 'package:jetboard/src/features/categories/data/requests/category_request.dart';
import 'package:sizer/sizer.dart';

class AddCategoryView extends StatefulWidget {
  final CategoriesCubit cubit;
  final String title;
  final CategoryModel? categoryModel;

  const AddCategoryView({
    required this.cubit,
    required this.title,
    this.categoryModel,
    super.key,
  });

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  TextEditingController nameEn = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController descriptionEn = TextEditingController();
  TextEditingController descriptionAr = TextEditingController();
  String? imageItems;

  void _show() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                DefaultText(
                  text: "${widget.title} Category",
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
                    shadowColor: AppColors.black.withOpacity(0.05),
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
                    shadowColor: AppColors.black.withOpacity(0.05),
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
                      shadowColor: AppColors.black.withOpacity(0.05),
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
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'English Description',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      return Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: widget.categoryModel != null
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: widget.categoryModel?.image == null
                                        ? widget.cubit.fileResult == null
                                            ? Container()
                                            : Image.memory(
                                                widget.cubit.fileResult!.files
                                                    .first.bytes!,
                                                fit: BoxFit.fitWidth,
                                                width: 100.w,
                                              )
                                        : Image.network(
                                            EndPoints.imageDomain +
                                                widget.categoryModel!.image!,
                                            fit: BoxFit.fitWidth,
                                            width: 100.w,
                                          ),
                                  ),
                                  Container(
                                    height: 4.h,
                                    width: 3.w,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color: AppColors.green,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        widget.cubit.pickImage();
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : widget.cubit.fileResult == null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.image),
                                      TextButton(
                                        onPressed: () {
                                          widget.cubit.pickImage();
                                        },
                                        child: const Text('Select Image'),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.memory(
                                          widget.cubit.fileResult!.files.first
                                              .bytes!,
                                          fit: BoxFit.fitWidth,
                                          width: 100.w,
                                        ),
                                      ),
                                      Container(
                                        height: 4.h,
                                        width: 3.w,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          color: AppColors.green,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            widget.cubit.pickImage();
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: AppColors.white,
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
                if (widget.categoryModel == null) {
                  widget.cubit.addCategory(
                    request: CategoryRequest(
                      nameEn: nameEn.text,
                      descriptionEn: descriptionEn.text,
                      nameAr: nameAr.text,
                      descriptionAr: descriptionAr.text,
                    ),
                  );
                } else {
                  widget.cubit.updateCategory(
                    request: CategoryRequest(
                      id: widget.categoryModel!.id,
                      nameEn: nameEn.text,
                      descriptionEn: descriptionEn.text,
                      nameAr: nameAr.text,
                      descriptionAr: descriptionAr.text,
                    ),
                  );
                }
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
                NavigationService.pop();
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
  }

  @override
  void initState() {
    if (widget.categoryModel != null) {
      nameEn.text = widget.categoryModel!.nameEn ?? "";
      descriptionEn.text = widget.categoryModel!.descriptionEn ?? "";
      nameAr.text = widget.categoryModel!.nameAr ?? "";
      descriptionAr.text = widget.categoryModel!.descriptionAr ?? "";
      imageItems = widget.categoryModel!.image ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    nameEn.clear();
    descriptionEn.clear();
    nameAr.clear();
    descriptionAr.clear();
    imageItems = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.categoryModel == null
        ? DefaultAppButton(
            width: 8.w,
            height: 5.h,
            haveShadow: false,
            offset: const Offset(0, 0),
            spreadRadius: 2,
            blurRadius: 2,
            radius: 10,
            gradientColors: const [
              AppColors.green,
              AppColors.lightGreen,
            ],
            fontSize: 4.sp,
            title: "Add",
            onTap: () {
              _show();
            },
          )
        : IconButton(
            onPressed: () {
              _show();
            },
            icon: const Icon(Icons.edit),
            color: AppColors.grey,
          );
  }
}
