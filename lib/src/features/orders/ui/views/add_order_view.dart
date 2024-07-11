import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/features/orders/ui/views/create_order.dart';
import 'package:sizer/sizer.dart';

class AddOrderView extends StatefulWidget {
  const AddOrderView({super.key});

  @override
  State<AddOrderView> createState() => _AddOrderViewState();
}

class _AddOrderViewState extends State<AddOrderView> {
  _show() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const CreateOrder();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppButton(
      width: 8.w,
      height: 5.h,
      haveShadow: false,
      offset: const Offset(0, 0),
      spreadRadius: 2,
      blurRadius: 2,
      radius: 10,
      gradientColors: const [
        AppColors.green,
        AppColors.lightGreen,
      ],
      fontSize: 4.sp,
      title: "Create",
      onTap: () {
        _show();
      },
    );
  }
}
