import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/items/items_desktop.dart';
import 'package:jetboard/src/core/shared/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const ItemsDesktop(),
    );
  }
}