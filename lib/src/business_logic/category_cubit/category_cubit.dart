import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetboard/src/data/network/requests/category_request.dart';
import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../data/models/packages_model.dart';
import '../../data/network/responses/category_response.dart';
import '../../presentation/widgets/toast.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);
  CategoryResponse? getCategoryResponse,
      getCategoryPackagesResponse,
      getCategoryItemsResponse,
      addCategoryResponse,
      addCategoryPackagesResponse,
      deleteCategoryResponse,
      deleteCategoryPackagesResponse,
      updateCategoryResponse,
      updateCategoryStatusResponse;
  List<PackagesModel> categoryList = [];
  List<PackagesItemsData> categoryPackagesList = [];
  List<PackagesItemsData> categoryItemsList = [];
  int listCount = 0;
  int packagesListCount = 0;
  int itemsListCount = 0;
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
    categoryList[index].active == 1
        ? categoryList[index].active = 0
        : categoryList[index].active = 1;
    emit(PickedSwitchState());
  }

  Future getCategories({String? keyword}) async {
    categoryList.clear();
    listCount = 0;
    try {
      emit(CategoryLodingState());
      await DioHelper.getData(
        url: EndPoints.getCategories,
        query: {
          "keyword": keyword,
        },
      ).then((value) {
        getCategoryResponse = CategoryResponse.fromJson(value.data);
        categoryList.addAll(getCategoryResponse!.categoryModel!);
        listCount = getCategoryResponse!.categoryModel!.length;
        emit(CategorySuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(CategoryErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CategoryErrorState());
      printError(e.toString());
    }
  }

  Future getCategoriesPackages(
      {int? id, required VoidCallback afterSucccess}) async {
    categoryPackagesList.clear();
    packagesListCount = 0;
    try {
      emit(CategoryPackagesLodingState());
      await DioHelper.getData(
        url: EndPoints.getCategoryDetails,
        query: {
          "id": id,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        getCategoryPackagesResponse = CategoryResponse.fromJson(value.data);
        categoryPackagesList
            .addAll(getCategoryPackagesResponse!.categoryDataModel!.packages!);
        packagesListCount =
            getCategoryPackagesResponse!.categoryDataModel!.packages!.length;
        emit(CategoryPackagesSuccessState());
        afterSucccess();
      });
    } on DioError catch (n) {
      emit(CategoryPackagesErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CategoryPackagesErrorState());
      printError(e.toString());
    }
  }

  Future getCategoriesItems(
      {int? id, required VoidCallback afterSucccess}) async {
    categoryItemsList.clear();
    itemsListCount = 0;
    try {
      emit(CategoryItemsLodingState());
      await DioHelper.getData(
        url: EndPoints.getCategoryDetails,
        query: {
          "id": id,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        getCategoryItemsResponse = CategoryResponse.fromJson(value.data);
        categoryItemsList
            .addAll(getCategoryItemsResponse!.categoryDataModel!.items!);
        itemsListCount =
            getCategoryItemsResponse!.categoryDataModel!.items!.length;
        emit(CategoryItemsSuccessState());
        afterSucccess();
      });
    } on DioError catch (n) {
      emit(CategoryItemsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CategoryItemsErrorState());
      printError(e.toString());
    }
  }

  Future addCategories({
    required CategoryRequest categoryRequest,
  }) async {
    try {
      emit(AddCategoryLodingState());
      await DioHelper.postData(
        url: EndPoints.addCategory,
        body: {
          'nameEn': categoryRequest.nameEn,
          'descriptionEn': categoryRequest.descriptionEn,
          'nameAr': categoryRequest.nameAr,
          'descriptionAr': categoryRequest.descriptionAr,
          'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
              filename: fileResult!.files.first.name),
        },
        formData: true,
      ).then((value) {
        printSuccess(value.toString());
        addCategoryResponse = CategoryResponse.fromJson(value.data);
        categoryList.insert(0, addCategoryResponse!.categoryDataModel!);
        listCount += 1;
        emit(AddCategorySuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(AddCategoryErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddCategoryErrorState());
      printError(e.toString());
    }
  }

  Future addCategoryItems({
    required CategoryRequest categoryRequest,
  }) async {
    printSuccess(categoryRequest.items.toString());

    try {
      emit(AddItemsCategoryLodingState());
      await DioHelper.postData(
        url: EndPoints.addCategoryItem,
        body: {
          'categoryId': categoryRequest.id,
          'itemId[]': categoryRequest.items,
        },
        formData: true,
      ).then((value) {
        printSuccess(value.toString());
        final myData = Map<String, dynamic>.from(value.data);
        emit(AddItemsCategorySuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(AddItemsCategoryErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddItemsCategoryErrorState());
      printError(e.toString());
    }
  }

  Future addCategoryPackages({
    required CategoryRequest categoryRequest,
  }) async {
    printSuccess(categoryRequest.package.toString());

    try {
      emit(AddPackagesCategoryLodingState());
      await DioHelper.postData(
        url: EndPoints.addCategoryPackage,
        body: {
          'categoryId': categoryRequest.id,
          'packageId[]': categoryRequest.package,
        },
        formData: true,
      ).then((value) {
        printSuccess(value.toString());
        emit(AddPackagesCategorySuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(AddPackagesCategoryErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddPackagesCategoryErrorState());
      printError(e.toString());
    }
  }

  Future updateCategories({
    required CategoryRequest categoryRequest,
    required int index,
  }) async {
    try {
      emit(UpdateCategoryLodingState());
      await DioHelper.postData(
        url: EndPoints.updateCategory,
        body: fileResult != null
            ? {
                'id': categoryRequest.id,
                'nameEn': categoryRequest.nameEn,
                'descriptionEn': categoryRequest.descriptionEn,
                'nameAr': categoryRequest.nameAr,
                'descriptionAr': categoryRequest.descriptionAr,
                'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
                    filename: fileResult!.files.first.name),
              }
            : {
                'id': categoryRequest.id,
                'nameEn': categoryRequest.nameEn,
                'descriptionEn': categoryRequest.descriptionEn,
                'nameAr': categoryRequest.nameAr,
                'descriptionAr': categoryRequest.descriptionAr,
              },
        formData: true,
      ).then((value) {
        updateCategoryResponse = CategoryResponse.fromJson(value.data);
        categoryList[index] = updateCategoryResponse!.categoryDataModel!;
        emit(UpdateCategorySuccessState());
        printSuccess(updateCategoryResponse!.categoryDataModel!.toString());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(UpdateCategoryErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateCategoryErrorState());
      printError(e.toString());
    }
  }

  Future updateCategoriesStatus({
    required CategoryRequest categoryRequest,
    required int index,
  }) async {
    try {
      emit(ChangeCategoryLodingState());
      await DioHelper.postData(
        url: EndPoints.changeCategoryStatus,
        body: {
          'id': categoryRequest.id,
          'active': categoryRequest.active,
        },
      ).then((value) {
        updateCategoryResponse = CategoryResponse.fromJson(value.data);
        categoryList[index].active = categoryRequest.active!;
        emit(ChangeCategorySuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(ChangeCategoryErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ChangeCategoryErrorState());
      printError(e.toString());
    }
  }

  Future deleteCategories({required PackagesModel packagesModel}) async {
    try {
      emit(DeeleteCategoryLodingState());
      await DioHelper.postData(
        url: EndPoints.deleteCategory,
        body: {
          'id': packagesModel.id,
        },
      ).then((value) {
        deleteCategoryResponse = CategoryResponse.fromJson(value.data);
        categoryList.remove(packagesModel);
        listCount -= 1;
        emit(DeeleteCategorySuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeeleteCategoryErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeeleteCategoryErrorState());
      printError(e.toString());
    }
  }

  Future deleteCategoryPackages({
    required PackagesItemsData packagesItemsData,
    required String type,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DeletePackagesCategoryLodingState());
      await DioHelper.postData(
        url: EndPoints.deleteCategorySub,
        body: {
          'id': packagesItemsData.relationId,
        },
      ).then((value) {
        deleteCategoryPackagesResponse = CategoryResponse.fromJson(value.data);
        if(type == "package"){
          categoryPackagesList.remove(packagesItemsData);

        }else{
          categoryItemsList.remove(packagesItemsData);
        }
        afterSuccess();
        emit(DeletePackagesCategorySuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeletePackagesCategoryErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeletePackagesCategoryErrorState());
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
