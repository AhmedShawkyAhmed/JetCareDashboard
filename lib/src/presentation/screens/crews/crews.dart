import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/crews/crews_desktop.dart';
import 'package:jetboard/src/core/shared/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Crews extends StatelessWidget {
  const Crews({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const CrewsDesktop(),
    );
  }
}