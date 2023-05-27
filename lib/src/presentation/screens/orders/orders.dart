import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/mobile.dart';
import 'package:jetboard/src/presentation/screens/orders/orders_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const OrdersDesktop(),
    );
  }
}