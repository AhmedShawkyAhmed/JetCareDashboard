import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'layout_desktop.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileLayout(),
      tablet: (_) => const MobileLayout(),
      desktop: (_) => const LayoutDesktop(),
    );
  }
}
