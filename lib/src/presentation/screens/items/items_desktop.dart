import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/item_cubit/items_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../../data/network/requests/items_request.dart';
import '../../widgets/default_app_button.dart';
import '../../widgets/default_text_field.dart';

class ItemsDesktop extends StatefulWidget {
  const ItemsDesktop({super.key});

  @override
  State<ItemsDesktop> createState() => _ItemsDesktopState();
}

class _ItemsDesktopState extends State<ItemsDesktop> {
  TextEditingController search = TextEditingController();
  final TextEditingController nameEn = TextEditingController();
  final TextEditingController descriptionEn = TextEditingController();
  final TextEditingController nameAr = TextEditingController();
  final TextEditingController descriptionAr = TextEditingController();
  final TextEditingController unit = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();

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
                padding: EdgeInsets.only(
                    top: 5.h, left: 3.w, right: 50, bottom: 1.h),
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
                      onChange: (value) {
                        if (value == "") {
                          ItemsCubit.get(context).getItems();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          ItemsCubit.get(context)
                              .getItems(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    BlocBuilder<ItemsCubit, ItemsState>(
                      builder: (context, state) {
                        return ItemsCubit.get(context).itemsTypes.isEmpty
                            ? const SizedBox()
                            : SizedBox(
                                width: 8.w,
                                height: 5.h,
                                child: DefaultDropdown<String>(
                                  hint: "Items",
                                  showSearchBox: true,
                                  selectedItem: item,
                                  items: ['All'] +
                                      ItemsCubit.get(context).itemsTypes,
                                  onChanged: (val) {
                                    setState(() {
                                      ItemsCubit.get(context).getItems(
                                          type: val == "All" ? " " : val);
                                      item = val!;
                                    });
                                  },
                                ),
                              );
                      },
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
                        AppColors.lightgreen,
                      ],
                      fontSize: 4.sp,
                      haveShadow: false,
                      title: "Add",
                      onTap: () {
                        setState(() {
                          GlobalCubit.get(context).isedit = false;
                          nameEn.clear();
                          descriptionEn.clear();
                          nameAr.clear();
                          descriptionAr.clear();
                          unit.clear();
                          price.clear();
                          quantity.clear();
                          dropItemsItem = "";
                          imageItems = null;
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
                                      text: "Add New Item",
                                      align: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
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
                                          top: 2.h, left: 3.w, right: 3.w),
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
                                          top: 2.h, left: 3.w, right: 3.w),
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
                                          top: 2.h, left: 3.w, right: 3.w),
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
                                          top: 2.h, left: 3.w, right: 3.w),
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
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'Unit',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
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
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'Price',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: quantity.text,
                                        password: false,
                                        height: 5.h,
                                        fontSize: 3.sp,
                                        controller: quantity,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'Quantity',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultDropdown<String>(
                                        hint: "Type",
                                        showSearchBox: true,
                                        selectedItem: dropItemsItem == ''
                                            ? ItemsCubit.get(context)
                                                .itemsTypes
                                                .first
                                            : dropItemsItem,
                                        items:
                                            ItemsCubit.get(context).itemsTypes,
                                        onChanged: (val) {
                                          setState(() {
                                            dropItemsItem = val!;
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 2.h, left: 3.w, right: 3.w),
                                        child:
                                            BlocBuilder<ItemsCubit, ItemsState>(
                                          builder: (context, state) {
                                            return Container(
                                              height: 20.h,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child:
                                                  GlobalCubit.get(context)
                                                          .isedit
                                                      ? Stack(
                                                          children: [
                                                            ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: imageItems ==
                                                                        null
                                                                    ? ItemsCubit.get(context).fileResult ==
                                                                            null
                                                                        ? Container()
                                                                        : Image
                                                                            .memory(
                                                                            ItemsCubit.get(context).fileResult!.files.first.bytes!,
                                                                            fit:
                                                                                BoxFit.fitWidth,
                                                                            width:
                                                                                100.w,
                                                                          )
                                                                    : Image
                                                                        .network(
                                                                        imageDomain +
                                                                            imageItems!,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                        width:
                                                                            100.w,
                                                                      )),
                                                            Container(
                                                              height: 4.h,
                                                              width: 3.w,
                                                              decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20)),
                                                                  color: AppColors
                                                                      .green),
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    ItemsCubit.get(
                                                                            context)
                                                                        .pickImage();
                                                                    imageItems =
                                                                        null;
                                                                    printSuccess(ItemsCubit.get(
                                                                            context)
                                                                        .fileResult
                                                                        .toString());
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.edit,
                                                                    color: AppColors
                                                                        .white,
                                                                  )),
                                                            )
                                                          ],
                                                        )
                                                      : ItemsCubit.get(context)
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
                                                                      ItemsCubit.get(
                                                                              context)
                                                                          .pickImage();
                                                                    },
                                                                    child: const Text(
                                                                        'Select Image'))
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
                                                                      ItemsCubit.get(
                                                                              context)
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
                                                                  height: 4.h,
                                                                  width: 3.w,
                                                                  decoration: const BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              20),
                                                                          bottomRight: Radius.circular(
                                                                              20)),
                                                                      color: AppColors
                                                                          .green),
                                                                  child: IconButton(
                                                                      onPressed: () {
                                                                        ItemsCubit.get(context)
                                                                            .pickImage();
                                                                      },
                                                                      icon: const Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color: AppColors
                                                                            .white,
                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                            );
                                          },
                                        )),
                                  ],
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: <Widget>[
                                DefaultAppButton(
                                  title: "Save",
                                  onTap: () {
                                    ItemsCubit.get(context).addItems(
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
                                    ItemsCubit.get(context).fileResult = null;
                                    Navigator.pop(context);
                                  },
                                  width: 10.w,
                                  height: 4.h,
                                  fontSize: 3.sp,
                                  textColor: AppColors.white,
                                  buttonColor: AppColors.pc,
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
              BlocBuilder<ItemsCubit, ItemsState>(
                builder: (context, state) {
                  if (ItemsCubit.get(context).itemsResponse?.itemsModel ==
                      null) {
                    return SizedBox(
                      height: 79.h,
                      child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) => Padding(
                          padding:
                              EdgeInsets.only(top: 1.h, left: 2.8.w, right: 37),
                          child: LoadingView(
                            width: 90.w,
                            height: 5.h,
                          ),
                        ),
                      ),
                    );
                  } else if (ItemsCubit.get(context)
                      .itemsResponse!
                      .itemsModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Items Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 88.h,
                    child: ListView.builder(
                      itemCount: ItemsCubit.get(context).listCount,
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
                                                title: const Text('Message'),
                                                content: Text(
                                                  ItemsCubit.get(context)
                                                      .itemList[index]
                                                      .nameEn
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        ItemsCubit.get(context)
                                            .itemList[index]
                                            .nameEn!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              width: 1.w,
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
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('Message'),
                                                content: Text(
                                                  ItemsCubit.get(context)
                                                      .itemList[index]
                                                      .nameAr
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        ItemsCubit.get(context)
                                            .itemList[index]
                                            .nameAr!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              width: 1.w,
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'DescriptionEn',
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
                                                title: const Text('Message'),
                                                content: Text(
                                                  ItemsCubit.get(context)
                                                      .itemList[index]
                                                      .descriptionEn
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        ItemsCubit.get(context)
                                            .itemList[index]
                                            .descriptionEn!,
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
                                      ItemsCubit.get(context)
                                          .itemList[index]
                                          .price
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
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('Message'),
                                                content: Text(
                                                  ItemsCubit.get(context)
                                                      .itemList[index]
                                                      .unit
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        ItemsCubit.get(context)
                                            .itemList[index]
                                            .unit!,
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
                                      'Type',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      ItemsCubit.get(context)
                                          .itemList[index]
                                          .type!,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: Image.network(
                                  imageDomain +
                                      ItemsCubit.get(context)
                                          .itemList[index]
                                          .image!,
                                  height: 6.h,
                                )),
                            SizedBox(
                              height: 2.5.h,
                              child: CircleAvatar(
                                backgroundColor: ItemsCubit.get(context)
                                            .itemList[index]
                                            .active ==
                                        1
                                    ? AppColors.green
                                    : AppColors.red,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Switch(
                                value: ItemsCubit.get(context)
                                            .itemList[index]
                                            .active ==
                                        1
                                    ? true
                                    : false,
                                activeColor: AppColors.green,
                                activeTrackColor: AppColors.lightgreen,
                                inactiveThumbColor: AppColors.red,
                                inactiveTrackColor: AppColors.lightGrey,
                                splashRadius: 3.0,
                                onChanged: (value) {
                                  ItemsCubit.get(context).switched(index);
                                  ItemsCubit.get(context).updateItemsStatus(
                                    indexs: index,
                                    itemsRequest: ItemsRequest(
                                      id: ItemsCubit.get(context)
                                          .itemList[index]
                                          .id,
                                      active: ItemsCubit.get(context)
                                              .itemList[index]
                                              .active!
                                              .isOdd
                                          ? 1
                                          : 0,
                                    ),
                                  );
                                }),
                            SizedBox(
                              width: 1.w,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    GlobalCubit.get(context).isedit = true;
                                    nameEn.text = ItemsCubit.get(context)
                                            .itemList[index]
                                            .nameEn ??
                                        "";
                                    descriptionEn.text = ItemsCubit.get(context)
                                            .itemList[index]
                                            .descriptionEn ??
                                        "";
                                    nameAr.text = ItemsCubit.get(context)
                                            .itemList[index]
                                            .nameAr ??
                                        "";
                                    descriptionAr.text = ItemsCubit.get(context)
                                            .itemList[index]
                                            .descriptionAr ??
                                        "";
                                    unit.text = ItemsCubit.get(context)
                                            .itemList[index]
                                            .unit ??
                                        "";
                                    price.text = ItemsCubit.get(context)
                                        .itemList[index]
                                        .price
                                        .toString();
                                    quantity.text = ItemsCubit.get(context)
                                        .itemList[index]
                                        .quantity
                                        .toString();
                                    dropItemsItem = ItemsCubit.get(context)
                                            .itemList[index]
                                            .type ??
                                        "";
                                    imageItems = ItemsCubit.get(context)
                                            .itemList[index]
                                            .image ??
                                        "";
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
                                                text: "Update Item",
                                                align: TextAlign.center,
                                              ),
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
                                                    right: 3.w),
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
                                                  shadowColor: AppColors.black
                                                      .withOpacity(0.05),
                                                  hintText: 'Unit',
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2.h,
                                                    left: 3.w,
                                                    right: 3.w),
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
                                                  shadowColor: AppColors.black
                                                      .withOpacity(0.05),
                                                  hintText: 'Price',
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2.h,
                                                    left: 3.w,
                                                    right: 3.w),
                                                child: DefaultTextField(
                                                  validator: quantity.text,
                                                  password: false,
                                                  height: 5.h,
                                                  fontSize: 3.sp,
                                                  controller: quantity,
                                                  haveShadow: true,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  color: AppColors.white,
                                                  shadowColor: AppColors.black
                                                      .withOpacity(0.05),
                                                  hintText: 'Quantity',
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2.h,
                                                    left: 3.w,
                                                    right: 3.w),
                                                child: DefaultDropdown<String>(
                                                  hint: "Type",
                                                  showSearchBox: true,
                                                  selectedItem: dropItemsItem ==
                                                          ''
                                                      ? ItemsCubit.get(context)
                                                          .itemsTypes
                                                          .first
                                                      : dropItemsItem,
                                                  items: ItemsCubit.get(context)
                                                      .itemsTypes,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      dropItemsItem = val!;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: BlocBuilder<ItemsCubit,
                                                      ItemsState>(
                                                    builder: (context, state) {
                                                      return Container(
                                                        height: 20.h,
                                                        width: 20.w,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: GlobalCubit.get(
                                                                    context)
                                                                .isedit
                                                            ? Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      child: imageItems ==
                                                                              null
                                                                          ? ItemsCubit.get(context).fileResult == null
                                                                              ? Container()
                                                                              : Image.memory(
                                                                                  ItemsCubit.get(context).fileResult!.files.first.bytes!,
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
                                                                            topLeft: Radius.circular(
                                                                                20),
                                                                            bottomRight: Radius.circular(
                                                                                20)),
                                                                        color: AppColors
                                                                            .green),
                                                                    child: IconButton(
                                                                        onPressed: () {
                                                                          ItemsCubit.get(context)
                                                                              .pickImage();
                                                                          imageItems =
                                                                              null;
                                                                          printSuccess(ItemsCubit.get(context)
                                                                              .fileResult
                                                                              .toString());
                                                                        },
                                                                        icon: const Icon(
                                                                          Icons
                                                                              .edit,
                                                                          color:
                                                                              AppColors.white,
                                                                        )),
                                                                  )
                                                                ],
                                                              )
                                                            : ItemsCubit.get(
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
                                                                      const Icon(
                                                                          Icons
                                                                              .image),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            ItemsCubit.get(context).pickImage();
                                                                          },
                                                                          child:
                                                                              const Text('Select Image'))
                                                                    ],
                                                                  )
                                                                : Stack(
                                                                    children: [
                                                                      ClipRRect(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          child:
                                                                              Image.memory(
                                                                            ItemsCubit.get(context).fileResult!.files.first.bytes!,
                                                                            fit:
                                                                                BoxFit.fitWidth,
                                                                            width:
                                                                                100.w,
                                                                          )),
                                                                      Container(
                                                                        height:
                                                                            4.h,
                                                                        width:
                                                                            3.w,
                                                                        decoration: const BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                                                            color: AppColors.green),
                                                                        child: IconButton(
                                                                            onPressed: () {
                                                                              ItemsCubit.get(context).pickImage();
                                                                            },
                                                                            icon: const Icon(
                                                                              Icons.edit,
                                                                              color: AppColors.white,
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                      );
                                                    },
                                                  )),
                                            ],
                                          ),
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        actions: <Widget>[
                                          DefaultAppButton(
                                            title: "Save",
                                            onTap: () {
                                              ItemsCubit.get(context)
                                                  .updateItems(
                                                index: index,
                                                itemsRequest: ItemsRequest(
                                                  id: ItemsCubit.get(context)
                                                      .itemList[index]
                                                      .id,
                                                  nameEn: nameEn.text,
                                                  descriptionEn:
                                                      descriptionEn.text,
                                                  nameAr: nameAr.text,
                                                  descriptionAr:
                                                      descriptionAr.text,
                                                  unit: unit.text,
                                                  price: int.parse(price.text),
                                                  quantity:
                                                      int.parse(quantity.text),
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
                                              ItemsCubit.get(context)
                                                  .fileResult = null;
                                              Navigator.pop(context);
                                              dropItemsItem = 'select';
                                            },
                                            width: 10.w,
                                            height: 4.h,
                                            fontSize: 3.sp,
                                            textColor: AppColors.white,
                                            buttonColor: AppColors.pc,
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
                                )),
                            SizedBox(
                              width: 1.w,
                            ),
                            IconButton(
                                onPressed: () {
                                  ItemsCubit.get(context).deleteItems(
                                      itemsModel: ItemsCubit.get(context)
                                          .itemList[index]);
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
