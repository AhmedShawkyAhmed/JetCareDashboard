import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/endDrawer_notification.dart';
import 'package:jetboard/src/presentation/views/header.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:sizer/sizer.dart';

class NotificationsDesktop extends StatelessWidget {
  TextEditingController search = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  NotificationsDesktop({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          drawerScrimColor: AppColors.transparent,
          key: scaffoldkey,
          endDrawer: EndDrawerWidgetNotification(),
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
                    padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50),
                    child: Header(
                      haveAdd: true,
                      haveDrawer: false,
                      search: search,
                      haveExport: false,

                      add: () {
                        scaffoldkey.currentState!.openEndDrawer();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 3.2.w, right: 43),
                    child: RowData(
                      data: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'ID',
                              style: TextStyle(fontSize: 3.sp),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Title',
                              style: TextStyle(fontSize: 3.sp),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Content',
                              style: TextStyle(fontSize: 3.sp),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 79.h,
                    child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (context, index) => Padding(
                        padding:
                            EdgeInsets.only(top: 2.h, left: 3.2.w, right: 43),
                        child: RowData(
                          data: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  index.toString(),
                                  style: TextStyle(fontSize: 3.sp),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Gold',
                                  style: TextStyle(fontSize: 3.sp),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  '100',
                                  style: TextStyle(fontSize: 3.sp),
                                )),
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
