import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/data/models/info_model.dart';
import 'package:jetboard/src/data/network/requests/info_request.dart';
import 'package:jetboard/src/data/network/responses/info_response.dart';
import 'package:jetboard/src/data/network/responses/type_response.dart';

import '../../core/shared/widgets/toast.dart';
part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit(this.networkService) : super(InfoCubitInitial());
  NetworkService networkService;
  static InfoCubit get(context) => BlocProvider.of(context);

  InfoResponse? infoResponse,deleteInfoResponse,addInfoResponse,updateInfoResponse;
  TypeResponse? typeResponse;
  List<String> infoTypes = [];
  List<InfoModel> infoList = [];
  int listCount = 0;

  Future getInfo({String? type,keyword}) async {
    infoList.clear();
    listCount= 0;
    try {
      emit(GetInfoLoadingState());
      await networkService.get(
        url: EndPoints.getInfo,
        query: {
          "type" : "appInfo",
          "keyword" : keyword,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        infoResponse = InfoResponse.fromJson(myData);
        infoList.addAll(infoResponse!.infoModel!);  
        listCount = infoResponse!.infoModel!.length;
        emit(GetInfoSuccessState());
      });
    } on DioError catch (n) {
      emit(GetInfoErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(GetInfoErrorState());
      printResponse(e.toString());
    }
  }

  Future getInfoTypes() async {
    try {
      emit(InfoTypeLoadingState());
      await networkService.get(
        url: EndPoints.getTypes,
      ).then((value) {
        printSuccess(value.data.toString());
        final myData = Map<String, dynamic>.from(value.data);
        typeResponse = TypeResponse.fromJson(myData);
        for (var i = 0; i < typeResponse!.typeModel!.length; i++) {
          infoTypes.add(typeResponse!.typeModel![i].type.toString());
        }
        infoTypes.insert(0,' ');
        emit(InfoTypeSuccessState());
        printResponse(value.data.toString());
      });
    } on DioError catch (n) {
      emit(InfoTypeErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(InfoTypeErrorState());
      printResponse(e.toString());
    }
  }

  Future addInfo({
   required InfoRequest infoRequest,
  }) async {
    try {
      emit(AddInfoLoadingState());
      await networkService.post(
        url: EndPoints.addInfo,
        body: {
          'titleEn': infoRequest.titleEn,
          'contentEn': infoRequest.contentEn,
          'titleAr': infoRequest.titleAr,
          'contentAr': infoRequest.contentAr,
          'type': infoRequest.type,
        },
        ).then((value) {
          final myData = Map<String, dynamic>.from(value.data);
          addInfoResponse = InfoResponse.fromJson(myData);
          infoList.insert(0,addInfoResponse!.infoModell!);
          listCount +=1;
          emit(AddInfoSuccessState());
          DefaultToast.showMyToast(value.data['message']);
        });
    } on DioError catch (n) {
      emit(AddInfoErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddInfoErrorState());
      printError(e.toString());
    }
  }

  Future updateInfo({
   required InfoRequest infoRequest,
   required int index,
  }) async {
    try {
      emit(AddInfoLoadingState());
      await networkService.post(
        url: EndPoints.updateInfo,
        body: {
          'id':infoRequest.id,
          'titleEn': infoRequest.titleEn,
          'contentEn': infoRequest.contentEn,
          'titleAr': infoRequest.titleAr,
          'contentAr': infoRequest.contentAr,
          'type': infoRequest.type,
        },
        ).then((value) {
          final myData = Map<String, dynamic>.from(value.data);
          updateInfoResponse = InfoResponse.fromJson(myData);
         // infoList.indexOf(updateInfoResponse!.infoModell!);
          infoList[index] = updateInfoResponse!.infoModell!;
          emit(AddInfoSuccessState());
          DefaultToast.showMyToast(value.data['message']);
        });
    } on DioError catch (n) {
      emit(AddInfoErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddInfoErrorState());
      printError(e.toString());
    }
  }

  Future deleteInfo({
   required InfoModel infoModel
  }) async {
    try {
      emit(DeleteInfoLoadingState());
      await networkService.post(
        url: EndPoints.deleteInfo,
        body: {
          'id': infoModel.id,
        },
        ).then((value) {
          final myData = Map<String, dynamic>.from(value.data);
          deleteInfoResponse = InfoResponse.fromJson(myData);
          infoList.remove(infoModel);
          listCount -=1;
          emit(DeleteInfoSuccessState());
         DefaultToast.showMyToast(value.data['message']);
        });
    } on DioError catch (n) {
      emit(DeleteInfoErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeleteInfoErrorState());
      printError(e.toString());
    }
  }
}


