import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/views/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'governorate_desktop.dart';

class Governorate extends StatelessWidget {
  const Governorate({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const GovernorateDesktop(),
    );
  }
}