import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/features/orders/cubit/orders_cubit.dart';
import 'package:sizer/sizer.dart';

class DeleteOrderView extends StatefulWidget {
  final OrdersCubit cubit;
  final int orderId;

  const DeleteOrderView({
    required this.cubit,
    required this.orderId,
    super.key,
  });

  @override
  State<DeleteOrderView> createState() => _DeleteOrderViewState();
}

class _DeleteOrderViewState extends State<DeleteOrderView> {
  _show() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                DefaultText(
                  text: "Are you Sure you want to Delete this Order !!",
                )
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Delete",
              onTap: () {
                widget.cubit.deleteOrder(
                  id: widget.orderId,
                );
              },
              width: 10.w,
              height: 4.h,
              fontSize: 3.sp,
              textColor: AppColors.white,
              buttonColor: AppColors.darkRed,
              isGradient: false,
              radius: 10,
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
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _show();
      },
      icon: const Icon(Icons.delete),
      color: AppColors.darkRed,
    );
  }
}
