import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'calender_desktop.dart';

class Calender extends StatelessWidget {
  const Calender({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const CalenderDesktop(),
    );
  }
}