import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/home/home_desktop.dart';
import 'package:jetboard/src/presentation/screens/home/home_mobile.dart';
import 'package:jetboard/src/presentation/screens/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const HomeDesktop(),
    );
  }
}