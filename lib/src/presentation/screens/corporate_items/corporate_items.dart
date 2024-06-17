import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/corporate_items/corporate_items_desktop.dart';
import 'package:jetboard/src/core/shared/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CorporateItems extends StatelessWidget {
  const CorporateItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const CorporateItemsDesktop(),
    );
  }
}