import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/screens/login/login_desktop_screen.dart';
import 'package:jetboard/src/presentation/screens/login/login_mobile_screen.dart';
import 'package:jetboard/src/presentation/screens/mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MobileLayout(),
      tablet: const MobileLayout(),
      desktop: LoginDeskTopScreen(),
      );
  }
}