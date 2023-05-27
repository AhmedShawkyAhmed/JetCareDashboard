import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/mobile.dart';
import 'package:jetboard/src/presentation/screens/notifications/notifications_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: const NotificationsDesktop(),
    );
  }
}