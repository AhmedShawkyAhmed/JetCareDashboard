import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jetboard/src/core/network/dio_consumer.dart';
import 'package:jetboard/src/core/network/dio_factory.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetboard/src/features/auth/data/repo/auth_repo.dart';
import 'package:jetboard/src/features/auth/service/auth_web_service.dart';
import 'package:jetboard/src/features/home/cubit/home_cubit.dart';
import 'package:jetboard/src/features/home/data/repo/home_repo.dart';
import 'package:jetboard/src/features/home/service/home_web_service.dart';
import 'package:jetboard/src/features/layout/cubit/layout_cubit.dart';
import 'package:jetboard/src/features/splash/cubit/splash_cubit.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // --------------------- Services
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  instance.registerLazySingleton<NetworkService>(() => DioConsumer(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<Dio>(() => dio);

  // --------------------- Cubit
  instance.registerFactory<SplashCubit>(() => SplashCubit());
  instance.registerFactory<AuthCubit>(() => AuthCubit(instance()));
  instance.registerFactory<LayoutCubit>(() => LayoutCubit());
  instance.registerFactory<HomeCubit>(() => HomeCubit(instance()));

  // --------------------- Repo
  instance.registerLazySingleton<AuthRepo>(() => AuthRepo(instance()));
  instance.registerLazySingleton<HomeRepo>(() => HomeRepo(instance()));

  // --------------------- Web Service
  instance.registerLazySingleton<AuthWebService>(() => AuthWebService(instance()));
  instance.registerLazySingleton<HomeWebService>(() => HomeWebService(instance()));
}