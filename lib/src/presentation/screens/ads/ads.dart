import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/ads/ads_desktop.dart';
import 'package:jetboard/src/presentation/screens/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Ads extends StatelessWidget {
  const Ads({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: AdsDesktop(),
    );
  }
}