import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/mobile.dart';
import 'package:jetboard/src/presentation/screens/support/support_desktop.dart';
import 'package:jetboard/src/presentation/screens/support/support_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: SupportDesktop(),
    );
  }
}