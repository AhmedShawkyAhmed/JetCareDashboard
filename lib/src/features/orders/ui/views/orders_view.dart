import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/comment_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/features/orders/cubit/orders_cubit.dart';
import 'package:jetboard/src/features/orders/ui/views/delete_order_view.dart';
import 'package:jetboard/src/features/orders/ui/views/view_orders_details.dart';
import 'package:sizer/sizer.dart';

class OrdersView extends StatefulWidget {
  final OrdersCubit cubit;

  const OrdersView({
    required this.cubit,
    super.key,
  });

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  TextEditingController commentController = TextEditingController();
  OrderStatus? orderStatus;

  Color getBackgroundColor(OrderStatus? status) {
    return status == OrderStatus.rejected || status == OrderStatus.canceled
        ? AppColors.red
        : status == OrderStatus.accepted || status == OrderStatus.confirmed
            ? AppColors.darkBlue
            : status == OrderStatus.completed
                ? AppColors.green
                : status == OrderStatus.assigned
                    ? AppColors.orange
                    : AppColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          itemCount: widget.cubit.orders!.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              top: 2.h,
              left: 2.5.w,
              right: 2.5.w,
              bottom: 1.h,
            ),
            child: RowData(
              rowHeight: 8.h,
              data: [
                SizedBox(
                  width: 5.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Number',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.orders![index].id.toString(),
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Client',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.orders![index].user!.name.toString(),
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Ordered At',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.orders![index].createdAt
                            .toString()
                            .substring(0, 10),
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.orders![index].date.toString(),
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Time',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        "${widget.cubit.orders![index].period!.from} - ${widget.cubit.orders![index].period!.to}",
                        style: TextStyle(fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                  child: SizedBox(
                    width: 10.w,
                    child: DefaultDropdown<OrderStatus>(
                      hint: "Status",
                      showSearchBox: true,
                      selectedItem: orderStatus == null
                          ? widget.cubit.orders![index].status
                          : orderStatus!,
                      items: OrderStatus.values,
                      onChanged: (val) {
                        widget.cubit.updateOrderStatus(
                          id: widget.cubit.orders![index].id!,
                          status: val!,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                SizedBox(
                  height: 3.h,
                  child: CircleAvatar(
                    backgroundColor:
                        getBackgroundColor(widget.cubit.orders![index].status),
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return ViewOrdersDetails(
                          cubit: widget.cubit,
                          orderModel: widget.cubit.orders![index],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.remove_red_eye),
                  color: AppColors.grey,
                ),
                SizedBox(
                  width: 1.w,
                ),
                CommentView(
                  comment: widget.cubit.orders![index].adminComment!,
                  onSave: (value) {
                    widget.cubit.updateAdminComment(
                      orderId: widget.cubit.orders![index].id!,
                      adminComment: value,
                      afterSuccess: () {
                        setState(() {
                          widget.cubit.orders![index].adminComment = value;
                        });
                      },
                    );
                  },
                ),
                SizedBox(
                  width: 1.w,
                ),
                DeleteOrderView(
                  cubit: widget.cubit,
                  orderId: widget.cubit.orders![index].id!,
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
