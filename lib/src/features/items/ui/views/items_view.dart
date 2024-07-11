import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/features/items/cubit/items_cubit.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:jetboard/src/features/items/data/requests/item_request.dart';
import 'package:jetboard/src/features/items/ui/views/add_item_view.dart';
import 'package:sizer/sizer.dart';

class ItemsView extends StatefulWidget {
  final ItemsCubit cubit;
  final ItemTypes type;

  const ItemsView({
    required this.cubit,
    required this.type,
    super.key,
  });

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  late List<ItemModel> localItems;

  @override
  void initState() {
    if (widget.type == ItemTypes.item) {
      localItems = widget.cubit.items ?? [];
    } else if (widget.type == ItemTypes.corporate) {
      localItems = widget.cubit.corporates ?? [];
    } else if (widget.type == ItemTypes.extra) {
      localItems = widget.cubit.extras ?? [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88.h,
      child: ListView.builder(
        itemCount: localItems.length,
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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Message'),
                              content: Text(
                                localItems[index].nameEn.toString(),
                                style: TextStyle(fontSize: 3.sp),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        localItems[index].nameEn!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ),
                  ],
                ),
              ),
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
                                localItems[index].nameAr.toString(),
                                style: TextStyle(fontSize: 3.sp),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        localItems[index].nameAr!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ),
                  ],
                ),
              ),
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
                                localItems[index].descriptionEn.toString(),
                                style: TextStyle(fontSize: 3.sp),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        localItems[index].descriptionEn!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ),
                  ],
                ),
              ),
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
                      localItems[index].price.toString(),
                      style: TextStyle(fontSize: 3.sp),
                    ),
                  ],
                ),
              ),
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
                                localItems[index].unit.toString(),
                                style: TextStyle(fontSize: 3.sp),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        localItems[index].unit!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.network(
                  EndPoints.imageDomain + localItems[index].image!,
                  height: 6.h,
                ),
              ),
              SizedBox(
                height: 2.5.h,
                child: CircleAvatar(
                  backgroundColor: localItems[index].isActive == true
                      ? AppColors.green
                      : AppColors.red,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Switch(
                value: localItems[index].isActive == true ? true : false,
                activeColor: AppColors.green,
                activeTrackColor: AppColors.lightGreen,
                inactiveThumbColor: AppColors.red,
                inactiveTrackColor: AppColors.lightGrey,
                splashRadius: 3.0,
                onChanged: (value) {
                  widget.cubit.switched(localItems[index]);
                },
              ),
              SizedBox(
                width: 1.w,
              ),
              AddItemView(
                cubit: widget.cubit,
                type: widget.type,
                title: "Update",
                itemModel: localItems[index],
              ),
              SizedBox(
                width: 1.w,
              ),
              IconButton(
                onPressed: () {
                  widget.cubit.deleteItem(
                    request: ItemRequest(
                      id: localItems[index].id,
                      type: localItems[index].type,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.red,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
