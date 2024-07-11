import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/views/comment_view.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/features/clients/cubit/clients_cubit.dart';
import 'package:jetboard/src/features/clients/ui/views/add_client_view.dart';
import 'package:sizer/sizer.dart';

class ClientsView extends StatefulWidget {
  final ClientsCubit cubit;

  const ClientsView({
    required this.cubit,
    super.key,
  });

  @override
  State<ClientsView> createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          itemCount: widget.cubit.clients!.length,
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
                        'Name',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.clients![index].name ?? "",
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
                        'Phone',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.clients![index].phone ?? "",
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.clients![index].email ?? "",
                        style: TextStyle(
                          fontSize: 2.5.sp,
                          fontWeight: FontWeight.bold,
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
                        'Rate',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.clients![index].rate.toString(),
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                  child: CircleAvatar(
                    backgroundColor:
                        widget.cubit.clients![index].isActive == true
                            ? AppColors.green
                            : AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Switch(
                  value: widget.cubit.clients![index].isActive == true
                      ? true
                      : false,
                  activeColor: AppColors.green,
                  activeTrackColor: AppColors.lightGreen,
                  inactiveThumbColor: AppColors.red,
                  inactiveTrackColor: AppColors.lightGrey,
                  splashRadius: 3.0,
                  onChanged: (value) {
                    widget.cubit.switched(widget.cubit.clients![index]);
                  },
                ),
                SizedBox(
                  width: 1.w,
                ),
                AddClientView(
                  cubit: widget.cubit,
                  title: "Update",
                  client: widget.cubit.clients![index],
                ),
                SizedBox(
                  width: 1.w,
                ),
                CommentView(
                  comment: widget.cubit.clients![index].adminComment!,
                  onSave: (value) {
                    widget.cubit.userAdminComment(
                      userId: widget.cubit.clients![index].id!,
                      adminComment: value,
                      afterSuccess: () {
                        setState(() {
                          widget.cubit.clients![index].adminComment = value;
                        });
                        NavigationService.pop();
                      },
                    );
                  },
                ),
                SizedBox(
                  width: 2.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
