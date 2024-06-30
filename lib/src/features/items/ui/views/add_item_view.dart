import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/core/utils/extensions.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/items/cubit/items_cubit.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:jetboard/src/features/items/data/requests/item_request.dart';
import 'package:sizer/sizer.dart';

class AddItemView extends StatefulWidget {
  final ItemsCubit cubit;
  final ItemTypes type;
  final String title;
  final ItemModel? itemModel;

  const AddItemView({
    required this.cubit,
    required this.type,
    required this.title,
    this.itemModel,
    super.key,
  });

  @override
  State<AddItemView> createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  TextEditingController nameEn = TextEditingController();
  TextEditingController descriptionEn = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController descriptionAr = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController price = TextEditingController();
  bool hasShipping = false;
  String? imageItems;

  bool get isCorporate => widget.type == ItemTypes.corporate;

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
                  text: "${widget.title} ${widget.type.name.toCapitalized()}",
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
                    validator: unit.text,
                    password: false,
                    height: 5.h,
                    fontSize: 3.sp,
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
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultTextField(
                    validator: price.text,
                    password: false,
                    height: 5.h,
                    fontSize: 3.sp,
                    controller: price,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'Price',
                  ),
                ),
                if (!isCorporate)
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
                  child: BlocBuilder<ItemsCubit, ItemsState>(
                    builder: (context, state) {
                      return Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: widget.itemModel != null
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: widget.itemModel?.image == null
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
                                                widget.itemModel!.image!,
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
                if(widget.itemModel == null){
                  widget.cubit.addItem(
                    request: ItemRequest(
                      nameEn: nameEn.text,
                      descriptionEn: descriptionEn.text,
                      nameAr: nameAr.text,
                      descriptionAr: descriptionAr.text,
                      unit: unit.text,
                      price: int.parse(price.text),
                      hasShipping: isCorporate ? false : hasShipping,
                      quantity: 1,
                      type: widget.type,
                    ),
                  );
                }else{
                  widget.cubit.updateItem(
                    request: ItemRequest(
                      nameEn: nameEn.text,
                      descriptionEn: descriptionEn.text,
                      nameAr: nameAr.text,
                      descriptionAr: descriptionAr.text,
                      unit: unit.text,
                      price: int.parse(price.text),
                      hasShipping: isCorporate ? false : hasShipping,
                      quantity: 1,
                      type: widget.type,
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
    if (widget.itemModel != null) {
      nameEn.text = widget.itemModel!.nameEn ?? "";
      descriptionEn.text = widget.itemModel!.descriptionEn ?? "";
      nameAr.text = widget.itemModel!.nameAr ?? "";
      descriptionAr.text = widget.itemModel!.descriptionAr ?? "";
      unit.text = widget.itemModel!.unit ?? "";
      price.text = widget.itemModel!.price.toString();
      hasShipping = widget.itemModel!.hasShipping ?? false;
      imageItems = widget.itemModel!.image ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    nameEn.clear();
    descriptionEn.clear();
    nameAr.clear();
    descriptionAr.clear();
    unit.clear();
    price.clear();
    hasShipping = false;
    imageItems = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.itemModel == null
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
