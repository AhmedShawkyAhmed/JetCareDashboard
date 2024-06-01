import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jetboard/src/core/network/dio_consumer.dart';
import 'package:jetboard/src/core/network/dio_factory.dart';
import 'package:jetboard/src/core/network/network_service.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // --------------------- Services
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  instance.registerLazySingleton<NetworkService>(() => DioConsumer(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<Dio>(() => dio);

  // --------------------- Cubit
  // instance.registerFactory<SplashCubit>(() => SplashCubit());

  // --------------------- Repo
  // instance.registerLazySingleton<AuthRepo>(() => AuthRepo(instance()));

  // --------------------- Web Service
  // instance.registerLazySingleton<AuthWebService>(() => AuthWebService(instance()));
}
