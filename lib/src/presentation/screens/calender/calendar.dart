import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'calendar_desktop.dart';


class calendar extends StatelessWidget {
  const calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const CalendarDesktop(),
    );
  }
}