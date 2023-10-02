import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/models/user_model.dart';
import 'package:jetboard/src/data/network/responses/crew_area_response.dart';
import 'package:jetboard/src/data/network/responses/statistics_response.dart';
import 'package:jetboard/src/data/network/responses/user_response.dart';
import 'package:jetboard/src/presentation/screens/ads/ads.dart';
import 'package:jetboard/src/presentation/screens/calender/calender.dart';
import 'package:jetboard/src/presentation/screens/corporate_items/corporate_items.dart';
import 'package:jetboard/src/presentation/screens/crews/crews.dart';
import 'package:jetboard/src/presentation/screens/equipment/equipment.dart';
import 'package:jetboard/src/presentation/screens/equipment_schedule/equipment_schedule.dart';
import 'package:jetboard/src/presentation/screens/extras/extras.dart';
import 'package:jetboard/src/presentation/screens/home/home.dart';
import 'package:jetboard/src/presentation/screens/info/info.dart';
import 'package:jetboard/src/presentation/screens/items/items.dart';
import 'package:jetboard/src/presentation/screens/login/login.dart';
import 'package:jetboard/src/presentation/screens/moderators/moderators.dart';
import 'package:jetboard/src/presentation/screens/notifications/notifications.dart';
import 'package:jetboard/src/presentation/screens/orders/orders.dart';
import 'package:jetboard/src/presentation/screens/packages/packages.dart';
import 'package:jetboard/src/presentation/screens/governorate/governorate.dart';
import 'package:jetboard/src/presentation/screens/support/support.dart';
import 'package:jetboard/src/presentation/screens/users/users.dart';

import '../../data/models/items_model.dart';
import '../../data/models/orders_model.dart';
import '../../data/network/responses/items_response.dart';
import '../../data/network/responses/packages_response.dart';
import '../../presentation/screens/areas/areas.dart';
import '../../presentation/screens/category/category.dart';
import '../../presentation/screens/corporates/corporates.dart';
import '../../presentation/screens/periods/periods.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

  Future navigate({required VoidCallback afterSuccess}) async {
    await Future.delayed(const Duration(milliseconds: 200), () {});
    afterSuccess();
  }

  PackagesResponse? packagesResponse;
  ItemsResponse? getItemsResponse, itemsResponse;
  StatisticsResponse? statisticsResponse;
  CrewAreaResponse? crewAreaResponse;
  UserResponse? userResponse;
  int listCount = 0;
  int selectedIndex = 0;
  bool isShadow = true;
  bool isedit = false;
  bool isColorS = true;
  List<String> packages = [];
  List<String> items = [];
  List<User> crews = [];
  List<UserModel> users = [];
  List<ItemsModel> itemListForPackages = [];

  List<Widget> pages = [
    const Home(),
    const Orders(),
    const Corporates(),
    const Users(),
    const Moderators(),
    const Crews(),
    const Calender(),
    const Category(),
    const Packages(),
    const Items(),
    const CorporateItems(),
    const ExtrasItems(),
    const Equipment(),
    const EquipmentSchedule(),
    const Ads(),
    const Governorate(),
    const Area(),
    const Periods(),
    const Support(),
    const Notifications(),
    const Info(),
    const Login(),
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    emit(AppChangeSideNavBarState());
  }

  void isShadowE() {
    isShadow = !isShadow;
    emit(AppChangeShadowState());
  }

  void switched(int index) {
    lol[index] == 1 ? lol[index] = 0 : lol[index] = 1;
    emit(AppChangeSwitchState());
  }

  Future getUser({required VoidCallback afterSuccess}) async {
    users.clear();
    try {
      emit(CrewLoadingState());
      await DioHelper.getData(
        url: EndPoints.getAccounts,
        query: {
          "type": "crew",
        },
      ).then((value) {
        printSuccess(value.data.toString());
        userResponse = UserResponse.fromJson(value.data);
        for (var i = 0; i < userResponse!.userModel!.length; i++) {
          users.add(userResponse!.userModel![i]);
        }
        emit(CrewSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(CrewErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CrewErrorState());
      printError(e.toString());
    }
  }

  Future getCrews({
    required int areaId,
    required int periodId,
    required String date,
  }) async {
    crews.clear();
    try {
      emit(CrewLoadingState());
      await DioHelper.getData(
        url: EndPoints.getCrewOfAreas,
        query: {
          "areaId": areaId,
          "periodId": periodId,
          "date": date,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        crewAreaResponse = CrewAreaResponse.fromJson(value.data);
        for (var i = 0; i < crewAreaResponse!.crews!.length; i++) {
          crews.add(crewAreaResponse!.crews![i].crew!);
        }
        emit(CrewSuccessState());
      });
    } on DioError catch (n) {
      emit(CrewErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CrewErrorState());
      printError(e.toString());
    }
  }

  Future getStatistics(
      {String? month, String? year, required VoidCallback afterSuccess}) async {
    try {
      emit(StatisticsLoadingState());
      await DioHelper.getData(url: EndPoints.getStatistics, query: {
        "month": month ?? DateTime.now().month.toString(),
        "year": year ?? DateTime.now().year.toString(),
      }).then((value) {
        printResponse(value.data.toString());
        statisticsResponse = StatisticsResponse.fromJson(value.data);
        emit(StatisticsSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(StatisticsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(StatisticsErrorState());
      printError(e.toString());
    }
  }

  Future getItems() async {
    try {
      emit(ItemsLoadingState());
      await DioHelper.getData(
        url: EndPoints.getItemsMobile,
      ).then((value) {
        itemsResponse = ItemsResponse.fromJson(value.data);
        for (int i = 0; i < itemsResponse!.itemsModel!.length; i++) {
          items.add(itemsResponse!.itemsModel![i].nameEn!);
        }
        emit(ItemsSuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(ItemsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ItemsErrorState());
      printError(e.toString());
    }
  }

  Future getPackages() async {
    try {
      emit(PackagesLoadingState());
      await DioHelper.getData(
        url: EndPoints.getPackagesMobile,
      ).then((value) {
        packagesResponse = PackagesResponse.fromJson(value.data);
        for (int i = 0; i < packagesResponse!.packagesModel!.length; i++) {
          packages.add(packagesResponse!.packagesModel![i].nameEn);
        }
        emit(PackagesSuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(PackagesErrorState());
      printError(n.toString());
    } catch (e) {
      emit(PackagesErrorState());
      printError(e.toString());
    }
  }

  Future getItemsForPackages({String? type, keyword,required VoidCallback afterSuccess}) async {
    try {
      emit(ItemsForPackagesLoadingState());
      await DioHelper.getData(
        url: EndPoints.getItems,
        query: {
          "type": 'item',
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        getItemsResponse = ItemsResponse.fromJson(myData);
        itemListForPackages.addAll(getItemsResponse!.itemsModel!);
        listCount = getItemsResponse!.itemsModel!.length;
        emit(ItemsForPackagesSuccessState());
        afterSuccess();
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(ItemsForPackagesErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ItemsForPackagesErrorState());
      printError(e.toString());
    }
  }
}
