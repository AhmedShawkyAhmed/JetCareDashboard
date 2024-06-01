import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/application/app.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/services/bloc_observer.dart';
import 'package:jetboard/src/core/services/cache_service.dart';
import 'package:jetboard/src/core/services/notification_service.dart';

void main() async {
  // customError();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.init();
  await Firebase.initializeApp();
  await NotificationService.init();
  Bloc.observer = MyBlocObserver();

  await initAppModule();

  runApp(
    MyApp(),
  );
}
