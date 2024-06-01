import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/models/packages_model.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:sizer/sizer.dart';
import '../../business_logic/packages_cubit/packages_cubit.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';

class ViewItems extends StatefulWidget {
  final List<PackagesItemsData> items;

  const ViewItems({
    super.key,
    required this.items,
  });

  @override
  State<ViewItems> createState() => _ViewItemsState();
}

class _ViewItemsState extends State<ViewItems> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackagesCubit, PackagesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.transparent,
          body: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            padding: EdgeInsets.only(left: 1.w, top: 1.h),
            height: 80.h,
            width: 80.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  color: AppColors.darkGrey.withOpacity(0.5),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.w),
                  child: Text(
                    'View Items',
                    style: TextStyle(fontSize: 5.sp),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                  width: 57.w,
                  child: ListView.builder(
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      return Padding(
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
                                                title: const Text('Arabic Name'),
                                                content: Text(
                                                  widget.items[index].nameAr!
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 3.sp),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        widget.items[index].nameAr!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ),
                                  ],
                                )),
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
                                              title: const Text('English Name'),
                                              content: Text(
                                                widget.items[index].nameEn!
                                                    .toString(),
                                                style:
                                                    TextStyle(fontSize: 3.sp),
                                              ),
                                            );
                                          });
                                    },
                                    child: Text(
                                      widget.items[index].nameEn!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                PackagesCubit.get(context).deletePackagesInfo(
                                  itemsModel: widget.items[index],
                                  afterSuccess: (){
                                    setState(() {
                                      PackagesCubit.get(context).deletePackagesInfoResponse!.packageDetails!.remove(widget.items[index]);
                                      widget.items.remove(widget.items[index]);
                                    });
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: AppColors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
