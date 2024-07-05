import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/packages/cubit/packages_cubit.dart';
import 'package:jetboard/src/features/packages/data/models/package_model.dart';
import 'package:jetboard/src/features/packages/data/requests/package_request.dart';
import 'package:sizer/sizer.dart';

class AddPackageView extends StatefulWidget {
  final PackagesCubit cubit;
  final String title;
  final PackageModel? packageModel;

  const AddPackageView({
    required this.cubit,
    required this.title,
    this.packageModel,
    super.key,
  });

  @override
  State<AddPackageView> createState() => _AddPackageViewState();
}

class _AddPackageViewState extends State<AddPackageView> {
  TextEditingController nameEn = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController descriptionEn = TextEditingController();
  TextEditingController descriptionAr = TextEditingController();
  TextEditingController price = TextEditingController();
  bool hasShipping = false;
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
                  text: "${widget.title} Package",
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
                  child: DefaultTextField(
                    validator: price.text,
                    password: false,
                    height: 7.h,
                    fontSize: 4.sp,
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
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultDropdown<bool>(
                    hint: "Has Shipping",
                    items: const [true, false],
                    selectedItem: hasShipping,
                    onChanged: (val) {
                      setState(() {
                        hasShipping = val!;
                        printLog(hasShipping);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: BlocBuilder<PackagesCubit, PackagesState>(
                    builder: (context, state) {
                      return Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: widget.packageModel != null
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: widget.packageModel?.image == null
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
                                                widget.packageModel!.image!,
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
                if (widget.packageModel == null) {
                  widget.cubit.addPackage(
                    request: PackageRequest(
                      nameEn: nameEn.text,
                      descriptionEn: descriptionEn.text,
                      nameAr: nameAr.text,
                      descriptionAr: descriptionAr.text,
                      price: double.parse(price.text),
                      hasShipping: hasShipping,
                      type: "package",
                    ),
                  );
                } else {
                  widget.cubit.updatePackage(
                    request: PackageRequest(
                      id: widget.packageModel!.id!,
                      nameEn: nameEn.text,
                      descriptionEn: descriptionEn.text,
                      nameAr: nameAr.text,
                      descriptionAr: descriptionAr.text,
                      price: double.parse(price.text),
                      hasShipping: hasShipping,
                      type: "package",
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
    if (widget.packageModel != null) {
      nameEn.text = widget.packageModel!.nameEn ?? "";
      descriptionEn.text = widget.packageModel!.descriptionEn ?? "";
      nameAr.text = widget.packageModel!.nameAr ?? "";
      descriptionAr.text = widget.packageModel!.descriptionAr ?? "";
      price.text = widget.packageModel!.price.toString();
      hasShipping = widget.packageModel!.hasShipping ?? false;
      imageItems = widget.packageModel!.image ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    nameEn.clear();
    descriptionEn.clear();
    nameAr.clear();
    descriptionAr.clear();
    price.clear();
    hasShipping = false;
    imageItems = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.packageModel == null
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
