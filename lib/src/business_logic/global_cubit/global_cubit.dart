import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/network/responses/period_response.dart';
import 'package:jetboard/src/data/network/responses/statistics_response.dart';
import 'package:jetboard/src/data/network/responses/user_response.dart';
import 'package:jetboard/src/presentation/screens/ads/ads.dart';
import 'package:jetboard/src/presentation/screens/home/home.dart';
import 'package:jetboard/src/presentation/screens/info/info.dart';
import 'package:jetboard/src/presentation/screens/items/items.dart';
import 'package:jetboard/src/presentation/screens/login/login.dart';
import 'package:jetboard/src/presentation/screens/orders/orders.dart';
import 'package:jetboard/src/presentation/screens/packages/packages.dart';
import 'package:jetboard/src/presentation/screens/support/support.dart';
import 'package:jetboard/src/presentation/screens/users/users.dart';

import '../../data/models/items_model.dart';
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

  PeriodResponsr? periodResponse;
  UserResponse? crewResponse,clientsResponse;
  PackagesResponse? packagesResponse;
  ItemsResponse? getItemsResponse,itemsResponse;
  StatisticsResponse? statisticsResponse;
  int listCount = 0;
  int selectedIndex = 0;
  bool isShadow = true;
  bool isedit = false;
  bool isColorS = true;
  List<String> periods = [];
  List<String> clients = [];
  List<String> packages = [];
  List<String> items = [];
  List<ItemsModel> itemListForPackages = [];

  List<Widget> pages = [
    const Home(), //1
    const Orders(), //2
    const Corporates(), //3
    const Users(), //4
    const Category(), //5
    const Packages(), //6
    const Items(), //7
    const Ads(), //9
    const Area(), //10
    //const calendar(),//11
    const Periods(), //12
    //const Spaces(), //13
    const Support(), //14
    //const Notifications(),//5
    const Info(), //8
    const Login(), //16
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

  Future getCrews(int areaId) async {
    crews.clear();
    try {
      emit(CrewLoadingState());
      await DioHelper.getData(
        url: EndPoints.getCrew,
        query: {
          "areaId": areaId,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        crewResponse = UserResponse.fromJson(value.data);
        crews.insert(0, "Crew");
        userId.insert(0, 0);
        for (var i = 0; i < crewResponse!.userModel!.length; i++) {
          crews.add(crewResponse!.userModel![i].name);
          userId.add(crewResponse!.userModel![i].id);
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
        for(int i = 0; i < itemsResponse!.itemsModel!.length;i++){
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
      emit(PackagesLodingState());
      await DioHelper.getData(
        url: EndPoints.getPackagesMobile,
      ).then((value) {
        packagesResponse = PackagesResponse.fromJson(value.data);
        for(int i = 0; i < packagesResponse!.packagesModel!.length;i++){
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

  Future getItemsForPackages({String? type, keyword}) async {
    try {
      emit(ItemsForPackagesLodingState());
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

  Future getPeriodsMobile() async {
    try {
      emit(PeriodLodingState());
      await DioHelper.getData(
        url: EndPoints.getPeriodsMobile,
      ).then((value) {
        periodResponse = PeriodResponsr.fromJson(value.data);
        emit(PeriodLodingState());
        for(int i = 0; i < periodResponse!.periodModel!.length;i++){
          periods.add("${periodResponse!.periodModel![i].from} - ${periodResponse!.periodModel![i].to}");
        }
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(PeriodLodingState());
      printError(n.toString());
    } catch (e) {
      emit(PeriodLodingState());
      printError(e.toString());
    }
  }

  Future getClients() async {
    try {
      emit(ClientsLoadingState());
      await DioHelper.getData(
        url: EndPoints.getAccounts,
        query: {
          "type": "client",
        },
      ).then((value) {
        clientsResponse = UserResponse.fromJson(value.data);
        for(int i = 0; i < clientsResponse!.userModel!.length;i++){
          clients.add(clientsResponse!.userModel![i].name);
        }
        emit(ClientsSuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(ClientsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ClientsErrorState());
      printError(e.toString());
    }
  }
}
