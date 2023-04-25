import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/item_cubit/items_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/data/models/items_model.dart';
import 'package:jetboard/src/data/network/requests/items_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_drop_down_menu.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants_variables.dart';

class EndDrawerWidgetItems extends StatefulWidget {
  EndDrawerWidgetItems({super.key, 
    this.endDrawerWidth,
    this.heightBackButton,
    this.widthBackButton,
    this.fontTitle,
    this.fontAllTextField,
    this.heightButton,
    this.widthButton,
    this.fontButton,
    this.index,
    this.itemsModel,
    required this.isEdit,
  });
  double? endDrawerWidth;
  double? heightBackButton, widthBackButton, fontTitle, fontAllTextField;
  double? heightButton, widthButton, fontButton;
  int? index;
  ItemsModel? itemsModel;
  bool isEdit;

  @override
  State<EndDrawerWidgetItems> createState() => _EndDrawerWidgetItemsState();
}

class _EndDrawerWidgetItemsState extends State<EndDrawerWidgetItems> {
  final TextEditingController nameEn = TextEditingController();
  final TextEditingController descriptionEn = TextEditingController();
  final TextEditingController nameAr = TextEditingController();
  final TextEditingController descriptionAr = TextEditingController();
  final TextEditingController unit = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      nameEn.text = widget.itemsModel?.nameEn ?? "";
      descriptionEn.text = widget.itemsModel?.descriptionEn ?? "";
      nameAr.text = widget.itemsModel?.nameAr ?? "";
      descriptionAr.text = widget.itemsModel?.descriptionAr ?? "";
      unit.text = widget.itemsModel?.unit ?? "";
      price.text = widget.itemsModel?.price.toString() ?? "";
      quantity.text = widget.itemsModel?.quantity.toString() ?? "";
      dropItemsItem = widget.itemsModel?.type ?? "";
      imageItems = widget.itemsModel?.image ?? "";
      printSuccess(widget.itemsModel!.image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = GlobalCubit.get(context);
    var cubitI = ItemsCubit.get(context);
    return BlocBuilder<ItemsCubit, ItemsState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 100.h,
              width: widget.endDrawerWidth ?? 23.w,
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 1.w, top: 3.h),
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
                              cubit.isedit ? 'Update Items' : 'Add New Items',
                              style:
                                  TextStyle(fontSize: widget.fontTitle ?? 6.sp),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 4.h, left: 3.w, right: 3.w),
                          child: DefaultTextField(
                            validator: nameEn.text,
                            password: false,
                            controller: nameEn,
                            height: 7.h,
                            fontSize: widget.fontAllTextField ?? 4.sp,
                            haveShadow: true,
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: AppColors.white,
                            shadowColor: AppColors.black.withOpacity(0.05),
                            hintText: 'NameEn',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            //vertical: 3.h,
                          ),
                          child: DefaultTextField(
                            validator: descriptionEn.text,
                            password: false,
                            height: 7.h,
                            fontSize: widget.fontAllTextField ?? 4.sp,
                            controller: descriptionEn,
                            haveShadow: true,
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: AppColors.white,
                            shadowColor: AppColors.black.withOpacity(0.05),
                            hintText: 'DescriptionEn',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            //vertical: 3.h,
                          ),
                          child: DefaultTextField(
                            validator: nameAr.text,
                            password: false,
                            controller: nameAr,
                            height: 7.h,
                            fontSize: widget.fontAllTextField ?? 4.sp,
                            haveShadow: true,
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: AppColors.white,
                            shadowColor: AppColors.black.withOpacity(0.05),
                            hintText: 'NameAr',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            //vertical: 3.h,
                          ),
                          child: DefaultTextField(
                            validator: descriptionAr.text,
                            password: false,
                            height: 7.h,
                            fontSize: widget.fontAllTextField ?? 4.sp,
                            controller: descriptionAr,
                            haveShadow: true,
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: AppColors.white,
                            shadowColor: AppColors.black.withOpacity(0.05),
                            hintText: 'DescriptionAr',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            //vertical: 3.h,
                          ),
                          child: DefaultTextField(
                            validator: unit.text,
                            password: false,
                            height: 7.h,
                            fontSize: widget.fontAllTextField ?? 4.sp,
                            controller: unit,
                            haveShadow: true,
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: AppColors.white,
                            shadowColor: AppColors.black.withOpacity(0.05),
                            hintText: 'Unit',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            //vertical: 3.h,
                          ),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            //vertical: 3.h,
                          ),
                          child: DefaultTextField(
                            validator: quantity.text,
                            password: false,
                            height: 7.h,
                            fontSize: widget.fontAllTextField ?? 4.sp,
                            controller: quantity,
                            haveShadow: true,
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: AppColors.white,
                            shadowColor: AppColors.black.withOpacity(0.05),
                            hintText: 'Quantity',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            //vertical: 3.h,
                          ),
                          child: DefaultDropDownMenu(
                            height: 7.h,
                            value: dropItemsItem == ''
                                ? cubitI.itemsTypes.first
                                : dropItemsItem,
                            hint: 'type',
                            list: cubitI.itemsTypes,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              //vertical: 3.h,
                            ),
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
                                            child: imageItems == null
                                                ? cubitI.fileResult == null
                                                    ? Container()
                                                    : Image.memory(
                                                        cubitI.fileResult!.files
                                                            .first.bytes!,
                                                        fit: BoxFit.fitWidth,
                                                        width: 100.w,
                                                      )
                                                : Image.network(
                                                    imageDomain + imageItems!,
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
                                                cubitI.pickImage();
                                                imageItems = null;
                                                printSuccess(
                                                    cubitI.fileResult.toString());
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: AppColors.white,
                                              )),
                                        )
                                      ],
                                    )
                                  : cubitI.fileResult == null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.image),
                                            TextButton(
                                                onPressed: () {
                                                  cubitI.pickImage();
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
                                                  cubitI.fileResult!.files.first
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
                                                    cubitI.pickImage();
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
                                      printError(
                                          widget.itemsModel!.id.toString());
                                      printError(
                                          widget.itemsModel!.id.toString());
                                      cubitI.updateItems(
                                        index: widget.index!,
                                        itemsRequest: ItemsRequest(
                                          id: widget.itemsModel!.id,
                                          nameEn: nameEn.text,
                                          descriptionEn: descriptionEn.text,
                                          nameAr: nameAr.text,
                                          descriptionAr: descriptionAr.text,
                                          unit: unit.text,
                                          price: int.parse(price.text),
                                          quantity: int.parse(quantity.text),
                                          type: dropItemsItem,
                                        ),
                                      );
                                      nameEn.clear();
                                      descriptionEn.clear();
                                      nameAr.clear();
                                      descriptionAr.clear();
                                      unit.clear();
                                      price.clear();
                                      quantity.clear();
                                      dropItemsItem = 'select';
                                      cubitI.fileResult = null;
                                      Navigator.pop(context);
                                    }
                                  : () {
                                      var formdata = formKey.currentState;
                                      if (formdata!.validate()) {
                                        cubitI.addItems(
                                            itemsRequest: ItemsRequest(
                                          nameEn: nameEn.text,
                                          descriptionEn: descriptionEn.text,
                                          nameAr: nameAr.text,
                                          descriptionAr: descriptionAr.text,
                                          unit: unit.text,
                                          price: int.parse(price.text),
                                          quantity: int.parse(quantity.text),
                                          type: dropItemsItem,
                                        ));
                                        nameEn.clear();
                                        descriptionEn.clear();
                                        nameAr.clear();
                                        descriptionAr.clear();
                                        unit.clear();
                                        price.clear();
                                        quantity.clear();
                                        cubitI.fileResult = null;
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
          ),
        );
      },
    );
  }
}
