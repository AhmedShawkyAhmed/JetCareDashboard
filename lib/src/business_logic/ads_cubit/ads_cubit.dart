import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/data/models/ads_model.dart';
import 'package:jetboard/src/data/network/requests/ads_request.dart';
import 'package:jetboard/src/data/network/responses/ads_response.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit(this.networkService) : super(AdsCubitInitial());
  NetworkService networkService;

  static AdsCubit get(context) => BlocProvider.of(context);
  AdsResponse? getAdsResponse,
      addAdsResponse,
      deleteAdsResponse,
      updateAdsResponse,
      updateAdsStatusResponse;
  List<AdsModel> adsList = [];
  int listCount = 0;
  int index = 0;
  String error = "";

  FilePickerResult? fileResult;

  Future pickImage() async {
    emit(AdsPickedImageLodindState());
    try {
      fileResult = await FilePicker.platform.pickFiles();
    } catch (e) {
      printError(e.toString());
    }
    if (fileResult != null) {
      emit(AdsPickedImageSuccessState());
      printSuccess(fileResult!.files.first.name.toString());
    }
  }

  void switched(int index) {
    adsList[index].active == 1
        ? adsList[index].active = 0
        : adsList[index].active = 1;
    emit(AdsSwitchState());
  }

  Future getAds({String? keyword}) async {
    adsList.clear();
    listCount = 0;
    try {
      emit(AdsLoadingState());
      await networkService.get(
        url: EndPoints.getAllAds,
        query: {
          "keyword": keyword,
        },
      ).then((value) {
        getAdsResponse = AdsResponse.fromJson(value.data);
        adsList.addAll(getAdsResponse!.adsModel!);
        listCount = getAdsResponse!.adsModel!.length;
        emit(AdsSuccessState());
      });
    } on DioError catch (n) {
      error = n.toString();
      emit(AdsErrorState());
      printError(n.toString());
    } catch (e) {
      error = e.toString();
      emit(AdsErrorState());
      printError(e.toString());
    }
  }

  Future addAds({
    required AdsRequest adsRequest,
  }) async {
    printSuccess(adsRequest.nameEn.toString());
    printSuccess(adsRequest.nameAr.toString());
    printSuccess(adsRequest.link.toString());
    printSuccess(fileResult!.files.first.name.toString());
    try {
      emit(AddAdsLoadingState());
      await networkService.post(
        url: EndPoints.addAds,
        body: {
          'nameEn': adsRequest.nameEn,
          'nameAr': adsRequest.nameAr,
          'link': adsRequest.link,
          'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
              filename: fileResult!.files.first.name),
        },
      ).then((value) {
        printSuccess(value.toString());
        addAdsResponse = AdsResponse.fromJson(value.data);
        adsList.insert(0, addAdsResponse!.adModel!);
        listCount += 1;
        emit(AddAdsSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(AddAdsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddAdsErrorState());
      printError(e.toString());
    }
  }

  Future updateAds({
    required AdsRequest adsRequest,
    required int index,
  }) async {
    try {
      emit(UpdateAdsLoadingState());
      await networkService.post(
        url: EndPoints.updateAds,
        body: fileResult != null
            ? {
                'id': adsRequest.id,
                'nameEn': adsRequest.nameEn,
                'nameAr': adsRequest.nameAr,
                'link': adsRequest.link,
                'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
                    filename: fileResult!.files.first.name),
              }
            : {
                'id': adsRequest.id,
                'nameEn': adsRequest.nameEn,
                'nameAr': adsRequest.nameAr,
                'link': adsRequest.link,
              },
      ).then((value) {
        printSuccess(value.data.toString());
        updateAdsResponse = AdsResponse.fromJson(value.data);
        adsList[index] = updateAdsResponse!.adModel!;
        emit(UpdateAdsSuccessState());
        printSuccess(updateAdsResponse!.adModel!.toString());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(UpdateAdsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateAdsErrorState());
      printError(e.toString());
    }
  }

  Future deleteAds({required AdsModel adsModel}) async {
    try {
      emit(DeleteAdsLoadingState());
      await networkService.post(
        url: EndPoints.deleteAds,
        body: {
          'id': adsModel.id,
        },
      ).then((value) {
        deleteAdsResponse = AdsResponse.fromJson(value.data);
        adsList.remove(adsModel);
        listCount -= 1;
        emit(DeleteAdsSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeleteAdsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeleteAdsErrorState());
      printError(e.toString());
    }
  }

  Future updateAdsStatus({
    required AdsRequest adsRequest,
    required int index,
  }) async {
    try {
      emit(ChangeAdsLoadingState());
      await networkService.post(
        url: EndPoints.changeAdsStatus,
        body: {
          'id': adsRequest.id,
          'active': adsRequest.active,
        },
      ).then((value) {
        updateAdsStatusResponse = AdsResponse.fromJson(value.data);
        adsList[index].active = adsRequest.active!;
        emit(ChangeAdsSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(ChangeAdsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ChangeAdsErrorState());
      printError(e.toString());
    }
  }
}

Future multipartConvertImage({
  required XFile image,
}) async {
  return MultipartFile.fromFileSync(image.path,
      filename: image.path.split('/').last);
}
