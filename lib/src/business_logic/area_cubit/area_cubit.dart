import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/models/area_model.dart';
import 'package:jetboard/src/data/network/requests/area_request.dart';
import 'package:jetboard/src/data/network/responses/area_response.dart';

import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../presentation/widgets/toast.dart';

part 'area_state.dart';

class AreaCubit extends Cubit<AreaState> {
  AreaCubit() : super(AreaInitial());

  static AreaCubit get(context) => BlocProvider.of(context);

  AreaResponse? getAreaResponse,
      getAllAreaResponse,
      addAreaResponse,
      deleteAreaResponse,
      updateAreaResponse,
      updateAreaStatusResponse;
  List<AreaModel> areaList = [];
  int listCount = 0;
  int areasCount = 0;
  int index = 0;
  List<String> areas = [];
  List<int> areaId = [];

  void switched(int index) {
    areaList[index].active == 1
        ? areaList[index].active = 0
        : areaList[index].active = 1;
    emit(PickedSwitchState());
  }

  Future getArea({String? keyword}) async {
    areaList.clear();
    listCount = 0;
    try {
      emit(AreaLoadingState());
      await DioHelper.getData(
        url: EndPoints.getAllAreas,
        query: {
          "keyword": keyword,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        getAreaResponse = AreaResponse.fromJson(value.data);
        areaList.addAll(getAreaResponse!.areaModel!);
        listCount = getAreaResponse!.areaModel!.length;
        emit(AreaSuccessState());
      });
    } on DioError catch (n) {
      emit(AreaErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AreaErrorState());
      printError(e.toString());
    }
  }

  Future getAllAreas({int? stateId}) async {
    areaList.clear();
    listCount = 0;
    try {
      emit(AreaLoadingState());
      await DioHelper.getData(
        url: EndPoints.getAreasOfState,
        query: {
          "stateId": stateId,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        getAreaResponse = AreaResponse.fromJson(value.data);
        areaList.addAll(getAreaResponse!.areaModel!);
        listCount = getAreaResponse!.areaModel!.length;
        for(int i = 0; i< areaList.length ; i++){
          areas.add(areaList[i].nameAr);
          areaId.add(areaList[i].id);
        }
        emit(AreaSuccessState());
      });
    } on DioError catch (n) {
      emit(AreaErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AreaErrorState());
      printError(e.toString());
    }
  }

  Future addArea({
    required AreaRequest areaRequest,
  }) async {
    try {
      emit(AddAreaLoadingState());
      await DioHelper.postData(
        url: EndPoints.addArea,
        body: {
          'stateId': areaRequest.stateId,
          'nameEn': areaRequest.nameEn,
          'nameAr': areaRequest.nameAr,
          'price': areaRequest.price,
        },
        formData: true,
      ).then((value) {
        printSuccess(value.toString());
        addAreaResponse = AreaResponse.fromJson(value.data);
        areaList.insert(0, addAreaResponse!.areaModell!);
        listCount += 1;
        emit(AddAreaSuccessState());
      });
    } on DioError catch (n) {
      emit(AddAreaErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddAreaErrorState());
      printError(e.toString());
    }
  }

  Future updateArea({
    required AreaRequest areaRequest,
    required int index,
  }) async {
    try {
      emit(UpdateAreaLoadingState());
      await DioHelper.postData(
        url: EndPoints.updatearea,
        body: {
          'id': areaRequest.id,
          'nameEn': areaRequest.nameEn,
          'nameAr': areaRequest.nameAr,
          'price': areaRequest.price,
        },
        formData: true,
      ).then((value) {
        printSuccess(value.data.toString());
        updateAreaResponse = AreaResponse.fromJson(value.data);
        areaList[index] = updateAreaResponse!.areaModell!;
        emit(UpdateAreaSuccessState());
        DefaultToast.showMyToast(value.data['message']);
        printSuccess(updateAreaResponse!.areaModell!.toString());
      });
    } on DioError catch (n) {
      emit(UpdateAreaErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateAreaErrorState());
      printError(e.toString());
    }
  }

  Future updateAreaStatus({
    required AreaRequest areaRequest,
    required int index,
  }) async {
    try {
      emit(ChangeAreaLoadingState());
      await DioHelper.postData(
        url: EndPoints.changeAreaStatus,
        body: {
          'id': areaRequest.id,
          'active': areaRequest.active,
        },
      ).then((value) {
        updateAreaStatusResponse = AreaResponse.fromJson(value.data);
        areaList[index].active = areaRequest.active!;
        emit(ChangeAreaSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(ChangeAreaErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ChangeAreaErrorState());
      printError(e.toString());
    }
  }

  Future deleteArea({required AreaModel areaModel}) async {
    try {
      emit(DeleteAreaLoadingState());
      await DioHelper.postData(
        url: EndPoints.deleteArea,
        body: {
          'id': areaModel.id,
        },
      ).then((value) {
        deleteAreaResponse = AreaResponse.fromJson(value.data);
        areaList.remove(areaModel);
        listCount -= 1;
        emit(DeleteAreaSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeleteAreaErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeleteAreaErrorState());
      printError(e.toString());
    }
  }
}
