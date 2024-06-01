import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/core/services/cache_service.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/data/network/requests/corporate_request.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/data/network/responses/items_response.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';

import '../../data/models/corporates_model.dart';
import '../../data/network/responses/corporates_response.dart';

part 'corporates_state.dart';

class CorporatesCubit extends Cubit<CorporatesState> {
  CorporatesCubit(this.networkService) : super(CorporatesInitial());
  NetworkService networkService;

  static CorporatesCubit get(context) => BlocProvider.of(context);
  CorporatesResponse? getCorporatesResponse;
  GlobalResponse? globalResponse;
  ItemsResponse? corporateItems;
  List<CorporatesModel> corporatesList = [];
  int listCount = 0;
  int index = 0;
  List<String> corporateNames = [];
  List<int> corporateIds = [];

  Future corporateOrder({
    required CorporateRequest corporateRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(CreateCorporateLoadingState());
      await networkService.post(url: EndPoints.addCorporateOrder, body: {
        'userId': CacheService.get(key: "id"),
        'name': corporateRequest.name,
        'email': corporateRequest.email,
        'phone': corporateRequest.phone,
        'message': corporateRequest.message,
        'itemId': corporateRequest.itemId,
      }).then((value) {
        DefaultToast.showMyToast("Order Created Successfully");
        emit(CreateCorporateSuccessState());
        getCorporates();
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(CreateCorporateErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CreateCorporateErrorState());
      printError(e.toString());
    }
  }

  Future getCorporatesItems({
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(CorporateItemsLoadingState());
      await networkService
          .get(
        url: EndPoints.getCorporates,
      )
          .then((value) {
        corporateItems = ItemsResponse.fromJson(value.data);
        for (int i = 0; i < corporateItems!.corporate!.length; i++) {
          corporateNames.add(corporateItems!.corporate![i].nameAr.toString());
          corporateIds.add(corporateItems!.corporate![i].id!);
        }
        emit(CorporateItemsSuccessState());
        afterSuccess();
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(CorporateItemsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CorporateItemsErrorState());
      printError(e.toString());
    }
  }

  Future getCorporates({
    String? keyword,
  }) async {
    corporatesList.clear();
    listCount = 0;
    try {
      emit(CorporatesLoadingState());
      await networkService.get(
        url: EndPoints.getCorporateOrders,
        query: {
          "keyword": keyword,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        getCorporatesResponse = CorporatesResponse.fromJson(myData);
        corporatesList.addAll(getCorporatesResponse!.corporatesModel!);
        listCount = getCorporatesResponse!.corporatesModel!.length;
        emit(CorporatesSuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(CorporatesErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CorporatesErrorState());
      printError(e.toString());
    }
  }

  Future corporateAdminComment({
    required int orderId,
    required String comment,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(UpdateCorporateStatusLoadingState());
      await networkService.post(url: EndPoints.corporateAdminComment, body: {
        'id': orderId,
        'comment': comment,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        DefaultToast.showMyToast(globalResponse!.message.toString());
        printSuccess(
            "Update Corporate Comment Response ${globalResponse!.message.toString()}");
        emit(UpdateCorporateStatusSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(UpdateCorporateStatusErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateCorporateStatusErrorState());
      printError(e.toString());
    }
  }
}
