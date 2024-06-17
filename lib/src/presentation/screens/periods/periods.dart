import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/mobile.dart';
import 'package:jetboard/src/presentation/screens/periods/periods_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Periods extends StatelessWidget {
  const Periods({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const PeriodsDesktop(),
    );
  }
}