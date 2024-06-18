import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/extras/extras_desktop.dart';
import 'package:jetboard/src/core/shared/views/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ExtrasItems extends StatelessWidget {
  const ExtrasItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const ExtrasDesktop(),
    );
  }
}