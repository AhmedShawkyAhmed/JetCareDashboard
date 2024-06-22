import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/data/models/user_model.dart';
import 'package:jetboard/src/data/network/responses/crew_area_response.dart';
import 'package:jetboard/src/data/network/responses/user_response.dart';

import '../../data/models/items_model.dart';
import '../../data/models/orders_model.dart';
import '../../data/network/responses/items_response.dart';
import '../../data/network/responses/packages_response.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit(this.networkService) : super(GlobalInitial());
  NetworkService networkService;

  static GlobalCubit get(context) => BlocProvider.of(context);

  Future navigate({required VoidCallback afterSuccess}) async {
    await Future.delayed(const Duration(milliseconds: 200), () {});
    afterSuccess();
  }

  PackagesResponse? packagesResponse;
  ItemsResponse? getItemsResponse, itemsResponse;
  CrewAreaResponse? crewAreaResponse;
  UserResponse? userResponse;
  int listCount = 0;
  int selectedIndex = 0;
  bool isShadow = true;
  bool isEdit = false;
  bool isColorS = true;
  List<String> packages = [];
  List<String> items = [];
  List<User> crews = [];
  List<UserModel> users = [];
  List<ItemsModel> itemListForPackages = [];

  void isShadowE() {
    isShadow = !isShadow;
    emit(AppChangeShadowState());
  }

  Future getUser({required VoidCallback afterSuccess}) async {
    users.clear();
    try {
      emit(CrewLoadingState());
      await networkService.get(
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
      await networkService.get(
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

  Future getItems() async {
    try {
      emit(ItemsLoadingState());
      await networkService
          .get(
        url: EndPoints.getItemsMobile,
      )
          .then((value) {
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
      await networkService
          .get(
        url: EndPoints.getPackagesMobile,
      )
          .then((value) {
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

  Future getItemsForPackages(
      {String? type, keyword, required VoidCallback afterSuccess}) async {
    try {
      emit(ItemsForPackagesLoadingState());
      await networkService.get(
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
