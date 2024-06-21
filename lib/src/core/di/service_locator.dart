import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jetboard/src/core/network/dio_consumer.dart';
import 'package:jetboard/src/core/network/dio_factory.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/features/ads/cubit/ads_cubit.dart';
import 'package:jetboard/src/features/ads/data/repo/ads_repo.dart';
import 'package:jetboard/src/features/ads/service/ads_web_service.dart';
import 'package:jetboard/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetboard/src/features/auth/data/repo/auth_repo.dart';
import 'package:jetboard/src/features/auth/service/auth_web_service.dart';
import 'package:jetboard/src/features/home/cubit/home_cubit.dart';
import 'package:jetboard/src/features/home/data/repo/home_repo.dart';
import 'package:jetboard/src/features/home/service/home_web_service.dart';
import 'package:jetboard/src/features/info/cubit/info_cubit.dart';
import 'package:jetboard/src/features/info/data/repo/info_repo.dart';
import 'package:jetboard/src/features/info/service/info_web_service.dart';
import 'package:jetboard/src/features/layout/cubit/layout_cubit.dart';
import 'package:jetboard/src/features/notifications/cubit/notifications_cubit.dart';
import 'package:jetboard/src/features/notifications/data/repo/notification_repo.dart';
import 'package:jetboard/src/features/notifications/service/notifications_web_service.dart';
import 'package:jetboard/src/features/periods/cubit/period_cubit.dart';
import 'package:jetboard/src/features/periods/data/repo/period_repo.dart';
import 'package:jetboard/src/features/periods/service/period_web_service.dart';
import 'package:jetboard/src/features/splash/cubit/splash_cubit.dart';
import 'package:jetboard/src/features/support/cubit/support_cubit.dart';
import 'package:jetboard/src/features/support/data/repo/support_repo.dart';
import 'package:jetboard/src/features/support/service/support_web_service.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // --------------------- Services
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  instance.registerLazySingleton<NetworkService>(() => DioConsumer(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<Dio>(() => dio);

  // --------------------- Cubit
  instance.registerFactory<AdsCubit>(() => AdsCubit(instance()));
  instance.registerFactory<AuthCubit>(() => AuthCubit(instance()));
  instance.registerFactory<HomeCubit>(() => HomeCubit(instance()));
  instance.registerFactory<InfoCubit>(() => InfoCubit(instance()));
  instance.registerFactory<LayoutCubit>(() => LayoutCubit());
  instance.registerFactory<NotificationsCubit>(() => NotificationsCubit(instance()));
  instance.registerFactory<PeriodCubit>(() => PeriodCubit(instance()));
  instance.registerFactory<SplashCubit>(() => SplashCubit());
  instance.registerFactory<SupportCubit>(() => SupportCubit(instance()));

  // --------------------- Repo
  instance.registerLazySingleton<AdsRepo>(() => AdsRepo(instance()));
  instance.registerLazySingleton<AuthRepo>(() => AuthRepo(instance()));
  instance.registerLazySingleton<HomeRepo>(() => HomeRepo(instance()));
  instance.registerLazySingleton<InfoRepo>(() => InfoRepo(instance()));
  instance.registerLazySingleton<NotificationRepo>(() => NotificationRepo(instance()));
  instance.registerLazySingleton<PeriodRepo>(() => PeriodRepo(instance()));
  instance.registerLazySingleton<SupportRepo>(() => SupportRepo(instance()));

  // --------------------- Web Service
  instance.registerLazySingleton<AdsWebService>(() => AdsWebService(instance()));
  instance.registerLazySingleton<AuthWebService>(() => AuthWebService(instance()));
  instance.registerLazySingleton<HomeWebService>(() => HomeWebService(instance()));
  instance.registerLazySingleton<InfoWebService>(() => InfoWebService(instance()));
  instance.registerLazySingleton<NotificationsWebService>(() => NotificationsWebService(instance()));
  instance.registerLazySingleton<PeriodWebService>(() => PeriodWebService(instance()));
  instance.registerLazySingleton<SupportWebService>(() => SupportWebService(instance()));
}
