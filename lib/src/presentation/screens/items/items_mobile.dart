import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/item_cubit/items_cubit.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/views/drawer_mobile.dart';
import 'package:jetboard/src/presentation/views/endDrawer_items.dart';
import 'package:jetboard/src/presentation/views/header.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:sizer/sizer.dart';

class ItemsMobile extends StatelessWidget {
  TextEditingController search = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  ItemsMobile({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubitI = ItemsCubit.get(context);
    int currentIndex = 0;
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          drawerScrimColor: AppColors.transparent,
          key: scaffoldkey,
          drawer: DrawerListMobile(),
          backgroundColor: AppColors.green,
          body: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 1.h, left: 1.w, right: 3.w),
                    child: Header(
                      haveAdd: true,
                      haveDrawer: true,
                      search: search,
                      haveExport: false,
                      menuButton: () => scaffoldkey.currentState!.openDrawer(),
                      widthSearch: 45.w,
                      fontSearch: 18.sp,
                      widthAdd: 20.w,
                      fontAdd: 15.sp,
                      add: () {
                        cubit.isEdit = false;
                        scaffoldkey.currentState!.openEndDrawer();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 3.2.w, right: 3.w),
                    child: RowData(
                      rowWidth: 94.w,
                      data: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'ID',
                              style: TextStyle(fontSize: 10.sp),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Name',
                              style: TextStyle(fontSize: 10.sp),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Status',
                              style: TextStyle(fontSize: 10.sp),
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Action',
                              style: TextStyle(fontSize: 10.sp),
                            )),
                        SizedBox(
                          width: 3.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 79.h,
                    child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (context, index) => Padding(
                        padding:
                            EdgeInsets.only(top: 2.h, left: 3.2.w, right: 3.w),
                        child: RowData(
                          rowWidth: 94.w,
                          data: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  index.toString(),
                                  style: TextStyle(fontSize: 10.sp),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Gold',
                                  style: TextStyle(fontSize: 10.sp),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Status',
                                  style: TextStyle(fontSize: 10.sp),
                                )),
                            IconButton(
                                onPressed: () {
                                  cubit.isEdit = true;
                                  scaffoldkey.currentState!.openEndDrawer();
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColors.grey,
                                )),
                            SizedBox(
                              width: 1.w,
                            ),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete,
                                      color: AppColors.red,
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
