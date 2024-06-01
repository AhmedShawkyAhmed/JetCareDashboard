import 'package:flutter/material.dart';
import 'package:jetboard/src/core/utils/extensions.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/presentation/screens/clients/clients_desktop.dart';
import 'package:jetboard/src/presentation/screens/info/info.dart';
import 'package:jetboard/src/presentation/screens/layout/layout.dart';
import 'package:jetboard/src/presentation/screens/login/login.dart';
import 'package:jetboard/src/presentation/screens/splash/splash.dart';
import 'package:jetboard/src/presentation/views/create_order.dart';

import 'app_animation.dart';
import 'routes.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings settings) {
    Routes? navigatedRoute =
        Routes.values.firstWhereOrNull((route) => route.path == settings.name);
    printSuccess("Route => $navigatedRoute");
    if (settings.name == '/') {
      navigatedRoute = Routes.splash;
    }
    switch (navigatedRoute) {
      case Routes.splash:
        return CustomPageRouteTransition.fadeOut(
          page: const Splash(),
        );
      case Routes.login:
        return CustomPageRouteTransition.fadeOut(
          page: const Login(),
        );
      case Routes.layout:
        return CustomPageRouteTransition.fadeOut(
          page: const Layout(),
        );
      case Routes.users:
        return CustomPageRouteTransition.fadeOut(
          page: const ClientsDesktop(),
        );
      case Routes.info:
        return CustomPageRouteTransition.fadeOut(
          page: const Info(),
        );
      case Routes.createOrder:
        return CustomPageRouteTransition.fadeOut(
          page: const CreateOrder(),
        );
      default:
        return null;
    }
  }
}
