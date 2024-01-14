import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/clients_cubit/clients_cubit.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/drawer_mobile.dart';
import 'package:jetboard/src/presentation/views/end_drawer_users.dart';
import 'package:jetboard/src/presentation/views/header.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:sizer/sizer.dart';

class ClientsMobile extends StatelessWidget {
  TextEditingController search = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  ClientsMobile({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubitU = ClientsCubit.get(context);
    int currentIndex = 0;
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          drawerScrimColor: AppColors.transparent,
          backgroundColor: AppColors.green,
          key: scaffoldkey,
          drawer: DrawerListMobile(),
          endDrawer: EndDrawerWidgetUsers(
            index: currentIndex,
            userModel:
                cubitU.clinetList.isEmpty ? null : cubitU.clinetList[currentIndex],
            endDrawerWidth: 65.w,
            widthBackButton: 7.w,
            fontTitle: 20.sp,
            fontAllTextField: 15.sp,
            heightButton: 7.h,
            widthButton: 25.w,
            fontButton: 15.sp,
          ),
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 2.h, left: 1.w, right: 3.w),
                      child: Header(
                        haveAdd: true,
                        haveDrawer: true,
                        menuButton: () =>
                            scaffoldkey.currentState!.openDrawer(),
                        widthSearch: 40.w,
                        fontSearch: 18.sp,
                        widthAdd: 15.w,
                        fontAdd: 10.sp,
                        widthExport: 15.w,
                        fontExport: 10.sp,
                        search: search,
                        haveExport: true,
                        add: () {
                          cubit.isShadowE();
                          cubit.isEdit = false;
                          scaffoldkey.currentState!.openEndDrawer();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.h,
                        left: 3.2.w,
                      ),
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
                            width: 8.w,
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Action',
                                style: TextStyle(fontSize: 10.sp),
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 79.h,
                      child: ListView.builder(
                        itemCount: 50,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              top: 2.h, left: 3.2.w, right: 3.w),
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
                                    'ahmed',
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
          ),
        );
      },
    );
  }
}
