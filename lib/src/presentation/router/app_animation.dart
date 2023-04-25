import 'package:flutter/cupertino.dart';

class CustomPageRouteTransiton extends PageRouteBuilder {
  final Widget page;
  final double dx;
  final double dy;
  final bool isFade;
  CustomPageRouteTransiton({
    required this.page,
    required this.dx,
    required this.dy,
    this.isFade = false,
  }) : super(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page);
  factory CustomPageRouteTransiton.fadeOut({
    required Widget page,
  }) =>
      CustomPageRouteTransiton(
        page: page,
        isFade: true,
        dx: 0,
        dy: 0,
      );
  factory CustomPageRouteTransiton.rightToLeft({
    required Widget page,
  }) =>
      CustomPageRouteTransiton(
        page: page,
        dx: 1,
        dy: 0,
      );
  factory CustomPageRouteTransiton.leftToRight({
    required Widget page,
  }) =>
      CustomPageRouteTransiton(
        page: page,
        dx: -1,
        dy: 0,
      );
  factory CustomPageRouteTransiton.bottomToTop({
    required Widget page,
  }) =>
      CustomPageRouteTransiton(
        page: page,
        dx: 0,
        dy: 1,
      );
  factory CustomPageRouteTransiton.topToBottom({
    required Widget page,
  }) =>
      CustomPageRouteTransiton(
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