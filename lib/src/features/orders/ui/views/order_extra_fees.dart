import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/features/orders/cubit/orders_cubit.dart';
import 'package:jetboard/src/features/orders/data/models/order_model.dart';
import 'package:sizer/sizer.dart';

class OrderExtraFees extends StatefulWidget {
  final OrdersCubit cubit;
  final OrderModel orderModel;

  const OrderExtraFees({
    required this.cubit,
    required this.orderModel,
    super.key,
  });

  @override
  State<OrderExtraFees> createState() => _OrderExtraFeesState();
}

class _OrderExtraFeesState extends State<OrderExtraFees> {
  TextEditingController priceController = TextEditingController();

  _show() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const DefaultText(
                  text: "Add Extra Price to The Order !!",
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: 2.h,
                ),
                DefaultTextField(
                  width: 20.w,
                  controller: priceController,
                  hintText: "Extra Price",
                  height: 5.h,
                  password: false,
                  haveShadow: false,
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Send",
              onTap: () {
                widget.cubit.addExtraFees(
                  orderId: widget.orderModel.id!,
                  extraFees: double.parse(
                      priceController.text == "" ? "0" : priceController.text),
                );
              },
              width: 10.w,
              height: 4.h,
              fontSize: 3.sp,
              textColor: AppColors.white,
              buttonColor: AppColors.primary,
              isGradient: false,
              radius: 10,
            ),
            const SizedBox(
              width: 10,
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
    return GestureDetector(
      onTap: () {
        _show();
      },
      child: Icon(
        Icons.edit,
        size: 3.sp,
        color: AppColors.grey,
      ),
    );
  }
}
