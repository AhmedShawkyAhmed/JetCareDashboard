import 'package:flutter/cupertino.dart';

class CustomPageRouteTransition extends PageRouteBuilder {
  final Widget page;
  final double dx;
  final double dy;
  final bool isFade;
  CustomPageRouteTransition({
    required this.page,
    required this.dx,
    required this.dy,
    this.isFade = false,
  }) : super(
      transitionDuration: const Duration(milliseconds: 10),
      pageBuilder: (context, animation, secondaryAnimation) => page);
  factory CustomPageRouteTransition.fadeOut({
    required Widget page,
  }) =>
      CustomPageRouteTransition(
        page: page,
        isFade: true,
        dx: 0,
        dy: 0,
      );
  factory CustomPageRouteTransition.rightToLeft({
    required Widget page,
  }) =>
      CustomPageRouteTransition(
        page: page,
        dx: 1,
        dy: 0,
      );
  factory CustomPageRouteTransition.leftToRight({
    required Widget page,
  }) =>
      CustomPageRouteTransition(
        page: page,
        dx: -1,
        dy: 0,
      );
  factory CustomPageRouteTransition.bottomToTop({
    required Widget page,
  }) =>
      CustomPageRouteTransition(
        page: page,
        dx: 0,
        dy: 1,
      );
  factory CustomPageRouteTransition.topToBottom({
    required Widget page,
  }) =>
      CustomPageRouteTransition(
        page: page,
        dx: 0,
        dy: -1,
      );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return !isFade
        ? SlideTransition(
      position: Tween<Offset>(begin: Offset(dx, dy), end: Offset.zero)
          .animate(animation),
      child: child,
    )
        : FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}