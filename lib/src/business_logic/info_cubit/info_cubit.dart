import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/models/info_model.dart';
import 'package:jetboard/src/data/network/requests/info_request.dart';
import 'package:jetboard/src/data/network/responses/info_response.dart';
import 'package:jetboard/src/data/network/responses/type_response.dart';
import 'package:meta/meta.dart';

import '../../presentation/widgets/toast.dart';
part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(InfoCubitInitial());

  static InfoCubit get(context) => BlocProvider.of(context);

  InfoResponse? infoResponse,deleteInfoResponse,addInfoResponse,updateInfoResponse;
  TypeResponse? typeRespons;
  List<String> infoTypes = [];
  List<InfoModel> infoList = [];
  int listCount = 0;

  Future getInfo({String? type,keyword}) async {
    infoList.clear();
    listCount= 0;
    try {
      emit(GetInfoLodingState());
      await DioHelper.getData(
        url: EndPoints.getInfo,
        query: {
          "type" : type,
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
      emit(InfoTypeLodingState());
      await DioHelper.getData(
        url: EndPoints.getTypes,
      ).then((value) {
        printSuccess(value.data.toString());
        final myData = Map<String, dynamic>.from(value.data);
        typeRespons = TypeResponse.fromJson(myData);
        for (var i = 0; i < typeRespons!.typeModel!.length; i++) {
          infoTypes.add(typeRespons!.typeModel![i].type.toString());
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
      emit(AddInfoLodingState());
      await DioHelper.postData(
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
          print(addInfoResponse!.infoModell);
          DefaultToast.showMyToast(value.data['message']);
        });
    } on DioError catch (n) {
      emit(AddInfoErrorState());
      print(n.toString());
    } catch (e) {
      emit(AddInfoErrorState());
      print(e.toString());
    }
  }

  Future updateInfo({
   required InfoRequest infoRequest,
   required int index,
  }) async {
    try {
      emit(AddInfoLodingState());
      await DioHelper.postData(
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
          print(updateInfoResponse!.infoModell);
          DefaultToast.showMyToast(value.data['message']);
        });
    } on DioError catch (n) {
      emit(AddInfoErrorState());
      print(n.toString());
    } catch (e) {
      emit(AddInfoErrorState());
      print(e.toString());
    }
  }

  Future deleteInfo({
   required InfoModel infoModel
  }) async {
     print(infoModel.id);
    try {
      emit(DeleteInfoLodingState());
      await DioHelper.postData(
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
      print(n.toString());
    } catch (e) {
      emit(DeleteInfoErrorState());
      print(e.toString());
    }
  }
}


