import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/item_cubit/items_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/endDrawer_items.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
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

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  String dropdownvalue = 'Item 1';
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubitI = ItemsCubit.get(context);
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      key: scaffoldkey,
      endDrawer: BlocBuilder<ItemsCubit, ItemsState>(
        builder: (context, state) {
          return EndDrawerWidgetItems(
            index: currentIndex,
            isEdit: cubit.isedit,
            itemsModel:
                cubitI.itemList.isEmpty ? null : cubitI.itemList[currentIndex],
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
                padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50,bottom: 1.h),
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
                          cubitI.getItems(keyword: search.text);
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
                            : Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(
                                          1, 1), // changes position of shadow
                                    )
                                  ],
                                ),
                                width: 6.w,
                                child: DropdownButton(
                                  icon:  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 4.sp,
                                  ),
                                  underline: const SizedBox(),
                                  value: cubitI.itemsTypes.first,
                                  items: cubitI.itemsTypes
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownvalue = value!;
                                      cubitI.getItems(type: value);
                                      printResponse(value);
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
                      radius: 10,
                      isGradient: false,
                      haveShadow: true,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                      buttonColor: AppColors.black,
                      fontSize: 5.sp,
                      title: "Export",
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
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
              BlocBuilder<ItemsCubit, ItemsState>(
                builder: (context, state) {
                  if (ItemsCubit.get(context).itemsResponse?.itemsModel ==
                      null) {
                    return SizedBox(
                      height: 79.h,
                      child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              top: 1.h, left: 2.8.w, right: 37),
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
                        text: "No Items Yet !",
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
                                      'NameEn',
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
                                                  cubitI.itemList[index].nameEn
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        cubitI.itemList[index].nameEn!,
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
                                                title: const Text('Message'),
                                                content: Text(
                                                  cubitI.itemList[index].nameAr
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        cubitI.itemList[index].nameAr!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ),
                                  ],
                                )),
                                SizedBox(width: 1.w,),
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
                                                  cubitI.itemList[index].descriptionEn
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        cubitI.itemList[index].descriptionEn!,
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
                                      cubitI.itemList[index].price.toString(),
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
                                      cubitI.itemList[index].unit!,
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
                                      cubitI.itemList[index].type!,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: Image.network(
                                  imageDomain + cubitI.itemList[index].image!,
                                  height: 6.h,
                                )),
                            SizedBox(
                              height: 2.5.h,
                              child: CircleAvatar(
                                backgroundColor:
                                    cubitI.itemList[index].active == 1
                                        ? AppColors.green
                                        : AppColors.red,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Switch(
                                value: cubitI.itemList[index].active == 1
                                    ? true
                                    : false,
                                activeColor: AppColors.green,
                                activeTrackColor: AppColors.lightgreen,
                                inactiveThumbColor: AppColors.red,
                                inactiveTrackColor: AppColors.lightGrey,
                                splashRadius: 3.0,
                                onChanged: (value) {
                                  cubitI.switched(index);
                                  cubitI.updateItemsStatus(
                                    indexs: index,
                                    itemsRequest: ItemsRequest(
                                      id: cubitI.itemList[index].id,
                                      active:
                                          cubitI.itemList[index].active!.isOdd
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
                                  cubit.isedit = true;
                                  currentIndex = index;
                                  scaffoldkey.currentState!.openEndDrawer();
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
                                  cubitI.deleteItems(
                                      itemsModel: cubitI.itemList[index]);
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
