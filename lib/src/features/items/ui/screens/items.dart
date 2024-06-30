import 'package:flutter/material.dart';
import 'package:jetboard/src/core/shared/views/mobile.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/features/items/ui/screens/items_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Items extends StatelessWidget {
  final ItemTypes type;

  const Items({
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileLayout(),
      tablet: (_) => const MobileLayout(),
      desktop: (_) => ItemsDesktop(type: type),
    );
  }
}
