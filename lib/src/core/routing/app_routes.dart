import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/utils/extensions.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetboard/src/features/auth/ui/screens/login.dart';
import 'package:jetboard/src/features/layout/cubit/layout_cubit.dart';
import 'package:jetboard/src/features/layout/ui/screens/layout.dart';
import 'package:jetboard/src/features/splash/cubit/splash_cubit.dart';
import 'package:jetboard/src/features/splash/ui/screens/splash.dart';

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
          page: BlocProvider(
            create: (context) => SplashCubit()..init(),
            child: const Splash(),
          ),
        );
      case Routes.login:
        return CustomPageRouteTransition.fadeOut(
          page: BlocProvider(
            create: (context) => AuthCubit(instance()),
            child: const Login(),
          ),
        );
      case Routes.layout:
        return CustomPageRouteTransition.fadeOut(
          page: BlocProvider(
            create: (context) => LayoutCubit(),
            child: const Layout(),
          ),
        );
      default:
        return null;
    }
  }
}
