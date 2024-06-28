import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/views/mobile.dart';
import 'package:jetboard/src/features/equipments/ui/screens/equipment_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Equipment extends StatelessWidget {
  const Equipment({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileLayout(),
      tablet: (_) => const MobileLayout(),
      desktop: (_) => const EquipmentsDesktop(),
    );
  }
}
