import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/router/app_animation.dart';
import 'package:jetboard/src/presentation/router/app_router_names.dart';
import 'package:jetboard/src/presentation/screens/info/info.dart';
import 'package:jetboard/src/presentation/screens/layout/layout.dart';
import 'package:jetboard/src/presentation/screens/login/login.dart';
import 'package:jetboard/src/presentation/screens/splash/splash.dart';
import 'package:jetboard/src/presentation/screens/users/users_desktop.dart';


class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.splash:
        return CustomPageRouteTransiton.fadeOut(
          page: const Splash(),
        );
      case AppRouterNames.login:
        return CustomPageRouteTransiton.fadeOut(
          page: const Login(),
        );
      case AppRouterNames.layout:
        return CustomPageRouteTransiton.fadeOut(
          page: const Layout(),
        ); 
      case AppRouterNames.users:
        return CustomPageRouteTransiton.fadeOut(
          page:  const UsersDesktop(),
        ); 
      case AppRouterNames.info:
        return CustomPageRouteTransiton.fadeOut(
          page:  const Info(),
        ); 
      default:
        return null;
    }
  }
}
