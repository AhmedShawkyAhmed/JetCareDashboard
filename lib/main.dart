import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jetboard/src/business_logic/Corporates_cubit/corporates_cubit.dart';
import 'package:jetboard/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetboard/src/business_logic/ads_cubit/ads_cubit.dart';
import 'package:jetboard/src/business_logic/area_cubit/area_cubit.dart';
import 'package:jetboard/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:jetboard/src/business_logic/bloc_observer.dart';
import 'package:jetboard/src/business_logic/calendar/calendar_cubit.dart';
import 'package:jetboard/src/business_logic/category_cubit/category_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/info_cubit/info_cubit.dart';
import 'package:jetboard/src/business_logic/item_cubit/items_cubit.dart';
import 'package:jetboard/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetboard/src/business_logic/orders_cubit/orders_cubit.dart';
import 'package:jetboard/src/business_logic/packages_cubit/packages_cubit.dart';
import 'package:jetboard/src/business_logic/period_cubit/period_cubit.dart';
import 'package:jetboard/src/business_logic/states_cubit/states_cubit.dart';
import 'package:jetboard/src/business_logic/support_cupit/support_cubit.dart';
import 'package:jetboard/src/business_logic/users_cubit/users_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/shared_preference_keys.dart';
import 'package:jetboard/src/data/data_provider/local/cache_helper.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/presentation/router/app_router.dart';
import 'package:jetboard/src/presentation/router/app_router_names.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

String? pushToken;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC36QGj3FRsMa4qomCOSVAA5DpnJU62kMU',
      appId: '1:873102526889:web:459167752edf3695015cb8',
      messagingSenderId: '873102526889',
      projectId: 'jetcare-f4e39',
      storageBucket: "jetcare-f4e39.appspot.com",
    ),
  );
  DioHelper.init();
  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();
      runApp(
        MyApp(appRouter: AppRouter()),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getToken();
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    super.initState();
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    DefaultToast.showMyToast(notification!.title.toString(),
        toastLength: Toast.LENGTH_LONG);
  }

  getToken() async {
    pushToken = await FirebaseMessaging.instance.getToken();
    printLog(pushToken.toString());
    CacheHelper.saveDataSharedPreference(
        key: SharedPreferenceKeys.fcm, value: pushToken);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: ((context) => GlobalCubit()
                ..getPeriodsMobile()
                ..getClients()),
            ),
            BlocProvider(
              create: ((context) => AuthCubit()),
            ),
            BlocProvider(
              create: ((context) => NotificationCubit()
                ..getNotifications(
                  userId: CacheHelper.getDataFromSharedPreference(key: "id"),
                )),
            ),
            BlocProvider(
              create: ((context) => InfoCubit()
                ..getInfo(type: "appInfo")
                ..getInfoTypes()),
            ),
            BlocProvider(
              create: ((context) => SupportCubit()..getSupport()),
            ),
            BlocProvider(
              create: ((context) => AdsCubit()..getAds()),
            ),
            BlocProvider(
              create: ((context) => ItemsCubit()
                ..getItems()
                ..getItemsTypes()
                ..getItemsForPackages()),
            ),
            BlocProvider(
              create: ((context) => UsersCubit()
                ..getUser()
                ..getRoles()),
            ),
            BlocProvider(
              create: ((context) => PackagesCubit()
                ..getPackages()
                ..getCategoryTypes()),
            ),
            BlocProvider(
              create: ((context) => StatesCubit()..getAllStates()),
            ),
            BlocProvider(
              create: ((context) => AreaCubit()..getAllAreas()),
            ),
            BlocProvider(
              create: ((context) => CalendarCubit()..getcalendar()),
            ),
            BlocProvider(
              create: ((context) => CorporatesCubit()..getCorporates()),
            ),
            BlocProvider(
              create: ((context) => CategoryCubit()..getCategories()),
            ),
            BlocProvider(
              create: ((context) => PeriodCubit()..getPeriod()),
            ),
            BlocProvider(
              create: ((context) => OrdersCubit()..getOrders()),
            ),
            BlocProvider(
              create: ((context) => AddressCubit()),
            ),
          ],
          child: BlocConsumer<GlobalCubit, GlobalState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Sizer(builder: (context, orientation, deviceType) {
                return MaterialApp(
                  title: 'JetCare',
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: widget.appRouter.onGenerateRoute,
                  initialRoute: AppRouterNames.splash,
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                );
              });
            },
          ),
        );
      },
    );
  }
}
