import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/mobile.dart';
import 'package:jetboard/src/presentation/screens/settings/settings_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const SettingsDesktop(),
    );
  }
}