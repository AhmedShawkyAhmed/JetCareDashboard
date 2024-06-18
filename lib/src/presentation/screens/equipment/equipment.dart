import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/equipment/equipment_desktop.dart';
import 'package:jetboard/src/core/shared/views/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';


class Equipment extends StatelessWidget {
  const Equipment({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const EquipmentsDesktop(),
    );
  }
}