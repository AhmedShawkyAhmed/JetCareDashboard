import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/views/mobile.dart';
import 'package:jetboard/src/presentation/screens/moderators/moderators_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Moderators extends StatelessWidget {
  const Moderators({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const ModeratorsDesktop(),
    );
  }
}