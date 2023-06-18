import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/equipment_schedule/equipment_schedule_desktop.dart';
import 'package:jetboard/src/presentation/equipment_schedule/equipment_schedule_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EquipmentSchedule extends StatelessWidget {
  const EquipmentSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const EquipmentScheduleMobile(),
      tablet: const EquipmentScheduleMobile(),
      desktop: const EquipmentScheduleDesktop(),
    );
  }
}