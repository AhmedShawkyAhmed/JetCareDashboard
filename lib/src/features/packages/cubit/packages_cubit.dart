import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/packages/data/models/package_details_model.dart';
import 'package:jetboard/src/features/packages/data/models/package_model.dart';
import 'package:jetboard/src/features/packages/data/repo/packages_repo.dart';
import 'package:jetboard/src/features/packages/data/requests/package_details_request.dart';
import 'package:jetboard/src/features/packages/data/requests/package_request.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit(this.repo) : super(PackagesInitial());
  final PackagesRepo repo;

  List<PackageModel>? packages;
  PackageDetailsModel? packageDetails;
  FilePickerResult? fileResult;

  Future pickImage() async {
    emit(PackagePickedImageLoading());
    try {
      fileResult = await FilePicker.platform.pickFiles();
    } catch (e) {
      printError(e.toString());
    }
    if (fileResult != null) {
      emit(PackagePickedImageSuccess());
      printSuccess(fileResult!.files.first.name.toString());
    }
  }

  Future switched(PackageModel package) async {
    await changePackageStatus(
      request: PackageRequest(
        id: package.id,
        isActive: !package.isActive!,
      ),
    );
    emit(PickedSwitchState());
  }

  Future getPackages({
    String? keyword,
  }) async {
    emit(GetPackagesLoading());
    var response = await repo.getPackages(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        packages = response.data;
        emit(GetPackagesSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetPackagesFailure());
        error.showError();
      },
    );
  }

  Future getPackageDetails({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    emit(GetPackageDetailsLoading());
    var response = await repo.getPackageDetails(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        packageDetails = response.data;
        emit(GetPackageDetailsSuccess());
        afterSuccess();
      },
      failure: (NetworkExceptions error) {
        emit(GetPackageDetailsFailure());
        error.showError();
      },
    );
  }

  Future addPackage({
    required PackageRequest request,
  }) async {
    emit(AddPackageLoading());
    var response = await repo.addPackage(
      request: request,
      image: File(fileResult!.files.first.name.toString()),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (packages != null) {
          packages!.add(response.data);
        }
        emit(AddPackageSuccess());
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AddPackageFailure());
        error.showError();
      },
    );
  }

  Future updatePackage({
    required PackageRequest request,
  }) async {
    emit(UpdatePackageLoading());
    var response = await repo.updatePackage(
      request: request,
      image: File(fileResult?.files.first.name ?? ""),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        PackageModel? package =
            packages!.firstWhere((package) => package.id == request.id);
        package.nameAr = request.nameAr;
        package.nameEn = request.nameEn;
        package.descriptionAr = request.descriptionAr;
        package.descriptionEn = request.descriptionEn;
        package.price = request.price;
        package.hasShipping = request.hasShipping;
        package.image = File(fileResult?.files.first.name ?? "").path;
        emit(UpdatePackageSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdatePackageFailure());
        error.showError();
      },
    );
  }

  Future changePackageStatus({
    required PackageRequest request,
  }) async {
    emit(UpdatePackageLoading());
    var response = await repo.changePackageStatus(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (packages != null) {
          packages!.firstWhere((package) => package.id == request.id).isActive =
              request.isActive;
        }
        emit(UpdatePackageSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdatePackageFailure());
        error.showError();
      },
    );
  }

  Future deletePackage({
    required int id,
  }) async {
    emit(DeletePackageLoading());
    var response = await repo.deletePackage(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (packages != null) {
          packages!.removeWhere((package) => package.id == id);
        }
        emit(DeletePackageSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeletePackageFailure());
        error.showError();
      },
    );
  }

  Future addPackageItem({
    required PackageDetailsRequest request,
  }) async {
    emit(AddPackageItemsLoading());
    var response = await repo.addPackageItem(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AddPackageItemsSuccess());
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AddPackageItemsFailure());
        error.showError();
      },
    );
  }

  Future deletePackageItem({
    required int id,
  }) async {
    emit(DeletePackageItemLoading());
    var response = await repo.deletePackageItem(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (packageDetails?.items != null) {
          packageDetails!.items!.removeWhere((package) => package.id == id);
        }

        emit(DeletePackageItemSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeletePackageItemFailure());
        error.showError();
      },
    );
  }
}
