import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/data/network/responses/categoryType_response.dart';
import 'package:jetboard/src/data/network/responses/package_details_response.dart';

import '../../data/models/packages_model.dart';
import '../../data/network/requests/packages_request.dart';
import '../../data/network/responses/packages_response.dart';
import '../../core/shared/widgets/toast.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit(this.networkService) : super(PackagesInitial());
  NetworkService networkService;

  static PackagesCubit get(context) => BlocProvider.of(context);
  CategoryTypeResponse? categoryResponse;
  PackageDetailsResponse? packageDetailsResponse;
  PackagesResponse? getPackagesResponse,
      getPackageDetails,
      addPackagesResponse,
      deletePackagesResponse,
      deletePackagesItemsResponse,
      deletePackagesInfoResponse,
      updatePackagesResponse,
      updatePackagesStatusResponse;
  List<PackagesModel> packageList = [];

  List<String> categoryTypes = [];
  int listCount = 0;

  int index = 0;

  FilePickerResult? fileResult;

  Future pickImage() async {
    emit(PickedImageLodindState());
    try {
      fileResult = await FilePicker.platform.pickFiles();
    } catch (e) {
      printError(e.toString());
    }
    if (fileResult != null) {
      emit(PickedImageSuccessState());
      printSuccess(fileResult!.files.first.name.toString());
    }
  }

  void switched(int index) {
    packageList[index].active == 1
        ? packageList[index].active = 0
        : packageList[index].active = 1;
    emit(PickedSwitchState());
  }

  Future getPackageInfo({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(PackageLoadingState());
      await networkService.get(url: EndPoints.getPackageDetails, query: {
        "id": id,
      }).then((value) {
        packageDetailsResponse = PackageDetailsResponse.fromJson(value.data);
        printSuccess(
            "Package Details Response ${packageDetailsResponse!.status.toString()}");
        emit(PackageSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(PackageErrorState());
      printError(n.toString());
    } catch (e) {
      emit(PackageErrorState());
      printError(e.toString());
    }
  }

  Future getPackages({
    String? keyword,
    type,
  }) async {
    packageList.clear();
    listCount = 0;
    try {
      emit(PackagesLoadingState());
      await networkService.get(
        url: EndPoints.getAllPackages,
        query: {
          "keyword": keyword,
          "type": type,
        },
      ).then((value) {
        getPackagesResponse = PackagesResponse.fromJson(value.data);
        packageList.addAll(getPackagesResponse!.packagesModel!);

        listCount = getPackagesResponse!.packagesModel!.length;
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

  Future getCategoryTypes() async {
    try {
      emit(CategoryTypeLoadingState());
      await networkService
          .get(
        url: EndPoints.getCategory,
      )
          .then((value) {
        printSuccess(value.data.toString());
        final myData = Map<String, dynamic>.from(value.data);
        categoryResponse = CategoryTypeResponse.fromJson(myData);
        for (var i = 0; i < categoryResponse!.categoryModel!.length; i++) {
          categoryTypes
              .add(categoryResponse!.categoryModel![i].titleAr.toString());
        }
        emit(CategoryTypeSuccessState());
        printResponse(value.data.toString());
      });
    } on DioError catch (n) {
      emit(CategoryTypeErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(CategoryTypeErrorState());
      printResponse(e.toString());
    }
  }

  Future addPackages({
    required PackagesRequest packagesRequest,
  }) async {
    try {
      emit(PackagesAddLoadingState());
      await networkService
          .post(
        url: EndPoints.addPackage,
        body: {
          'nameEn': packagesRequest.nameEn,
          'descriptionEn': packagesRequest.descriptionEn,
          'nameAr': packagesRequest.nameAr,
          'descriptionAr': packagesRequest.descriptionAr,
          'type': packagesRequest.type,
          'price': packagesRequest.price,
          'hasShipping': packagesRequest.hasShipping,
          'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
              filename: fileResult!.files.first.name),
        },
      )
          .then((value) {
        printSuccess(value.toString());
        final myData = Map<String, dynamic>.from(value.data);
        addPackagesResponse = PackagesResponse.fromJson(myData);
        packageList.insert(0, addPackagesResponse!.packagesDataModel!);
        listCount += 1;
        emit(PackagesAddSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(PackagesAddErrorState());
      printError(n.toString());
    } catch (e) {
      emit(PackagesAddErrorState());
      printError(e.toString());
    }
  }

  Future addPackagesItems({
    required int packageId,
    required List<String> nameAr,
    required List<String> nameEn,
  }) async {
    try {
      emit(PackagesItemsAddLoadingState());
      await networkService
          .post(
        url: EndPoints.addPackageItem,
        body: {
          'packageId': packageId,
          'nameAr[]': nameAr,
          'nameEn[]': nameEn,
        },
      )
          .then((value) {
        printSuccess(value.toString());
        emit(PackagesItemsAddSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(PackagesItemsAddErrorState());
      printError(n.toString());
    } catch (e) {
      emit(PackagesItemsAddErrorState());
      printError(e.toString());
    }
  }

  Future updatePackages({
    required PackagesRequest packagesRequest,
    required int index,
  }) async {
    try {
      emit(PackagesUpdateLoadingState());
      await networkService
          .post(
        url: EndPoints.updatePackage,
        body: fileResult != null
            ? {
                'id': packagesRequest.id,
                'nameEn': packagesRequest.nameEn,
                'descriptionEn': packagesRequest.descriptionEn,
                'nameAr': packagesRequest.nameAr,
                'descriptionAr': packagesRequest.descriptionAr,
                'price': packagesRequest.price,
                'hasShipping': packagesRequest.hasShipping,
                'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
                    filename: fileResult!.files.first.name),
              }
            : {
                'id': packagesRequest.id,
                'nameEn': packagesRequest.nameEn,
                'descriptionEn': packagesRequest.descriptionEn,
                'nameAr': packagesRequest.nameAr,
                'descriptionAr': packagesRequest.descriptionAr,
                'price': packagesRequest.price,
                'hasShipping': packagesRequest.hasShipping,
              },
      )
          .then((value) {
        printSuccess(value.data.toString());
        final myData = Map<String, dynamic>.from(value.data);
        updatePackagesResponse = PackagesResponse.fromJson(myData);
        packageList[index] = updatePackagesResponse!.packagesDataModel!;
        emit(PackagesUpdateSuccessState());
        printSuccess(updatePackagesResponse!.packagesDataModel!.toString());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(PackagesUpdateErrorState());
      printError(n.toString());
    } catch (e) {
      emit(PackagesUpdateErrorState());
      printError(e.toString());
    }
  }

  Future updatePackagesStatus({
    required PackagesRequest packagesRequest,
    required int indexs,
  }) async {
    try {
      emit(ChangePackagesLoadingState());
      await networkService.post(
        url: EndPoints.changePackageStatus,
        body: {
          'id': packagesRequest.id,
          'active': packagesRequest.active,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        updatePackagesStatusResponse = PackagesResponse.fromJson(myData);
        packageList[indexs].active = packagesRequest.active!;
        emit(ChangePackagesSuccessState());
        DefaultToast.showMyToast(value.data['message']);
        //printResponse(supportList);
      });
    } on DioError catch (n) {
      emit(ChangePackagesErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(ChangePackagesErrorState());
      printResponse(e.toString());
    }
  }

  Future deletePackages({required PackagesModel packagesModel}) async {
    try {
      emit(PackagesDeleteLoadingState());
      await networkService.post(
        url: EndPoints.deletePackage,
        body: {
          'id': packagesModel.id,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        deletePackagesResponse = PackagesResponse.fromJson(myData);
        packageList.remove(packagesModel);
        listCount -= 1;
        emit(PackagesDeleteSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(PackagesDeleteErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(PackagesDeleteErrorState());
      printResponse(e.toString());
    }
  }

  Future deletePackagesItems(
      {required PackagesItemsData packagesItemsData, int? indexs}) async {
    try {
      emit(PackagesItemsDeleteLoadingState());
      await networkService.post(
        url: EndPoints.deleteCategorySub,
        body: {
          'id': packagesItemsData.relationId,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        deletePackagesItemsResponse = PackagesResponse.fromJson(myData);
        packageList[indexs!].items!.remove(packagesItemsData);
        emit(PackagesItemsDeleteSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(PackagesItemsDeleteErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(PackagesItemsDeleteErrorState());
      printResponse(e.toString());
    }
  }

  Future deletePackagesInfo(
      {required PackagesItemsData itemsModel,
      required VoidCallback afterSuccess}) async {
    try {
      emit(PackagesItemsDeleteLoadingState());
      printLog(itemsModel.id.toString());
      await networkService.post(
        url: EndPoints.deletePackageInfo,
        body: {
          'id': itemsModel.id,
        },
      ).then((value) {
        deletePackagesInfoResponse = PackagesResponse.fromJson(value.data);
        emit(PackagesItemsDeleteSuccessState());
        afterSuccess();
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(PackagesItemsDeleteErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(PackagesItemsDeleteErrorState());
      printResponse(e.toString());
    }
  }
}

Future multipartConvertImage({
  required XFile image,
}) async {
  return MultipartFile.fromFileSync(image.path,
      filename: image.path.split('/').last);
}
