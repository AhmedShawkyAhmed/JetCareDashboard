import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/ads/data/models/ads_model.dart';
import 'package:jetboard/src/features/ads/data/repo/ads_repo.dart';
import 'package:jetboard/src/features/ads/data/requests/ads_request.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit(this.repo) : super(AdsInitial());
  final AdsRepo repo;

  List<AdsModel>? ads;

  FilePickerResult? fileResult;

  Future pickImage() async {
    emit(AdsPickedImageLoading());
    try {
      fileResult = await FilePicker.platform.pickFiles();
    } catch (e) {
      printError(e.toString());
    }
    if (fileResult != null) {
      emit(AdsPickedImageSuccess());
      printSuccess(fileResult!.files.first.name.toString());
    }
  }

  Future switched(AdsModel ad) async {
    await changeAdStatus(
      request: AdsRequest(
        id: ad.id,
        isActive: !ad.isActive!,
      ),
    );
    emit(PickedSwitchState());
  }

  Future getAds({
    String? keyword,
  }) async {
    emit(GetAdsLoading());
    var response = await repo.getAds(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        ads = response.data;
        emit(GetAdsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetAdsFailure());
        error.showError();
      },
    );
  }

  Future addAds({
    required AdsRequest request,
  }) async {
    emit(AddAdsLoading());
    var response = await repo.addAds(
      request: request,
      image: File(fileResult!.files.first.name.toString()),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (ads != null) {
          ads!.add(response.data);
        }
        emit(AddAdsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AddAdsFailure());
        error.showError();
      },
    );
  }

  Future updateAds({
    required AdsRequest request,
  }) async {
    emit(UpdateAdsLoading());
    var response = await repo.updateAds(
      request: request,
      image: File(fileResult?.files.first.name ?? ""),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (ads != null) {
          AdsModel adsModel = ads!.firstWhere((item) => item.id == request.id);
          adsModel.nameAr = request.nameAr;
          adsModel.nameEn = request.nameEn;
          adsModel.link = request.link;
          adsModel.image = File(fileResult?.files.first.name ?? "").path;
        }
        emit(UpdateAdsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateAdsFailure());
        error.showError();
      },
    );
  }

  Future changeAdStatus({
    required AdsRequest request,
  }) async {
    emit(UpdateAdsLoading());
    var response = await repo.changeAdStatus(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (ads != null) {
          ads!.firstWhere((item) => item.id == request.id).isActive =
              request.isActive;
        }
        emit(UpdateAdsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateAdsFailure());
        error.showError();
      },
    );
  }

  Future deleteAds({
    required int id,
  }) async {
    emit(UpdateAdsLoading());
    var response = await repo.deleteAds(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (ads != null) {
          ads!.removeWhere((item) => item.id == id);
        }
        emit(UpdateAdsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateAdsFailure());
        error.showError();
      },
    );
  }
}
