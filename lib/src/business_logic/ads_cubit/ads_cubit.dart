import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/models/ads_model.dart';
import 'package:jetboard/src/data/network/requests/ads_request.dart';
import 'package:jetboard/src/data/network/responses/ads_response.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsCubitInitial());

  static AdsCubit get(context) => BlocProvider.of(context);
  AdsResponse? getAdsResponse,
      addAdsResponse,
      deleteAdsResponse,
      updateAdsResponse,
      updateAdsStatusResponse;
  List<AdsModel> adsList = [];
  int listCount = 0;
  int index = 0;

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
      emit(AdsLodingState());
      await DioHelper.getData(
        url: EndPoints.getAds,
        query: {
          "keyword": keyword,
        },
      ).then((value) {
        getAdsResponse = AdsResponse.fromJson(value.data);
        adsList.addAll(getAdsResponse!.adsModel!);
        listCount = getAdsResponse!.adsModel!.length;
        emit(AdsSuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(AdsErrorState());
      printError(n.toString());
    } catch (e) {
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
      emit(AddAdsLodingState());
      await DioHelper.postData(
        url: EndPoints.addAds,
        body: {
          'nameEn': adsRequest.nameEn,
          'nameAr': adsRequest.nameAr,
          'link': adsRequest.link,
          'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
              filename: fileResult!.files.first.name),
        },
        formData: true,
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
      emit(UpdateAdsLodingState());
      await DioHelper.postData(
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
        formData: true,
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
      emit(DeleteAdsLodingState());
      await DioHelper.postData(
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
      emit(ChangeAdsLodingState());
      await DioHelper.postData(
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
