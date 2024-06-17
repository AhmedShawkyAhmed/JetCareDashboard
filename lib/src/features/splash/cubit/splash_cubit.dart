import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/constants/cache_keys.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/routing/routes.dart';
import 'package:jetboard/src/core/services/cache_service.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/auth/cubit/auth_cubit.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> init() async {
    String? token = CacheService.get(key: CacheKeys.token);
    printLog("Token | $token");
    await Future.delayed(const Duration(seconds: 2), () {
      if (token == null) {
        NavigationService.pushNamedAndRemoveUntil(
          Routes.login,
          (route) => false,
        );
      } else {
        AuthCubit(instance()).getProfile();
      }
    });
  }
}
