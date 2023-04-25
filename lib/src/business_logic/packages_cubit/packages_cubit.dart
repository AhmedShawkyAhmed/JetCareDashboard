import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetboard/src/data/models/items_model.dart';
import 'package:jetboard/src/data/network/responses/categoryType_response.dart';
import 'package:jetboard/src/data/network/responses/package_details_response.dart';
import 'package:meta/meta.dart';

import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../data/models/packages_model.dart';
import '../../data/network/requests/packages_request.dart';
import '../../data/network/responses/packages_response.dart';
import '../../presentation/widgets/toast.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit() : super(PackagesInitial());
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
  List<PackagesModel> packageList= [];

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
      await DioHelper.getData(url: EndPoints.getPackageDetails, query: {
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


  Future getPackages({String? keyword,type,}) async {
    packageList.clear();
    listCount= 0;
    try {
      emit(PackagesLodingState());
      await DioHelper.getData(
        url: EndPoints.getPackages,
        query: {
          "keyword" : keyword,
          "type" : type,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        getPackagesResponse = PackagesResponse.fromJson(myData);
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
      emit(CategoryTypeLodingState());
      await DioHelper.getData(
        url: EndPoints.getCategory,
      ).then((value) {
        printSuccess(value.data.toString());
        final myData = Map<String, dynamic>.from(value.data);
        categoryResponse = CategoryTypeResponse.fromJson(myData);
        for (var i = 0; i < categoryResponse!.categoryModel!.length; i++) {
          categoryTypes.add(categoryResponse!.categoryModel![i].titleAr.toString());
        }
        categoryTypes.insert(0,'');
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
      emit(PackagesAddLodingState());
      await DioHelper.postData(
        url: EndPoints.addPackage,
        body: {
          'nameEn': packagesRequest.nameEn,
          'descriptionEn': packagesRequest.descriptionEn,
          'nameAr': packagesRequest.nameAr,
          'descriptionAr': packagesRequest.descriptionAr,
          'type': packagesRequest.type,
          'price': packagesRequest.price,
          'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
              filename: fileResult!.files.first.name),
        },
        formData: true,
      ).then((value) {
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
      emit(PackagesItemsAddLodingState());
      await DioHelper.postData(
        url: EndPoints.addPackageItem,
        body: {
          'packageId': packageId,
          'nameAr[]': nameAr,
          'nameEn[]': nameEn,
        },
        formData: true,
      ).then((value) {
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
      emit(PackagesUpdateLodingState());
      await DioHelper.postData(
        url: EndPoints.updatePackage,
        body: fileResult != null
            ? {
                'id': packagesRequest.id,
                'nameEn': packagesRequest.nameEn,
                'descriptionEn': packagesRequest.descriptionEn,
                'nameAr': packagesRequest.nameAr,
                'discriptionAr': packagesRequest.descriptionAr,
                'price': packagesRequest.price,
                'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
                    filename: fileResult!.files.first.name),
              }
            : {
                'id': packagesRequest.id,
                'nameEn': packagesRequest.nameEn,
                'descriptionEn': packagesRequest.descriptionEn,
                'nameAr': packagesRequest.nameAr,
                'discriptionAr': packagesRequest.descriptionAr,
                'price': packagesRequest.price,
              },
              formData: true,
      ).then((value) {
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
      emit(ChangePackagesLodingState());
      await DioHelper.postData(
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
      emit(PackagesDeleteLodingState());
      await DioHelper.postData(
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

  Future deletePackagesItems({required PackagesItemsData packagesItemsData, int? indexs}) async {
    try {
      emit(PackagesItemsDeleteLodingState());
      await DioHelper.postData(
        url: EndPoints.deletePackageItem,
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

  Future deletePackagesInfo({required PackagesItemsData itemsModel,required VoidCallback afterSuccess}) async {
    try {
      emit(PackagesItemsDeleteLodingState());
      printLog(itemsModel.id.toString());
      await DioHelper.postData(
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

