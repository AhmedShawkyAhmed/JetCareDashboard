import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/equipment/equipment_desktop.dart';
import 'package:jetboard/src/presentation/equipment/equipment_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';


class Equipment extends StatelessWidget {
  const Equipment({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const EquipmentsMobile(),
      tablet: const EquipmentsMobile(),
      desktop: const EquipmentsDesktop(),
    );
  }
}