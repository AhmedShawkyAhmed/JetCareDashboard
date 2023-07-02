import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/models/items_model.dart';
import 'package:jetboard/src/data/network/requests/items_request.dart';
import 'package:jetboard/src/data/network/responses/items_response.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';

part 'corporate_item_state.dart';

class CorporateItemCubit extends Cubit<CorporateItemState> {
  CorporateItemCubit() : super(CorporateItemInitial());

  static CorporateItemCubit get(context) => BlocProvider.of(context);

  ItemsResponse? itemsResponse,
      getItemsResponse,
      addItemsResponse,
      deleteItemsResponse,
      updateItemsResponse,
      updateItemsStatusResponse;
  List<ItemsModel> itemListForPackages = [];
  int count = 0;
  int listCount = 0;
  List<ItemsModel> itemList = [];
  List<String> itemsTypes = [];

  FilePickerResult? fileResult;

  Future pickImage() async {
    emit(ItemsPickedImageLoadingState());
    try {
      fileResult = await FilePicker.platform.pickFiles();
    } catch (e) {
      printError(e.toString());
    }
    if (fileResult != null) {
      emit(ItemsPickedImageSuccessState());
      printSuccess(fileResult!.files.first.name.toString());
    }
  }

  void switched(int index) {
    itemList[index].active == 1
        ? itemList[index].active = 0
        : itemList[index].active = 1;
    emit(AdsSwitchState());
  }

  Future getItems({String? type, keyword}) async {
    itemsResponse = null;
    itemList.clear();
    listCount = 0;
    try {
      emit(ItemsLoadingState());
      await DioHelper.getData(
        url: EndPoints.getItems,
        query: {
          "type": type,
          "keyword": keyword,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        itemsResponse = ItemsResponse.fromJson(myData);
        itemList.addAll(itemsResponse!.itemsModel!);
        listCount = itemsResponse!.itemsModel!.length;
        emit(ItemsSuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(ItemsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ItemsErrorState());
      printError(e.toString());
    }
  }

  Future addItems({
    required ItemsRequest itemsRequest,
  }) async {
    try {
      emit(AddItemsLoadingState());
      await DioHelper.postData(
        url: EndPoints.addItem,
        body: {
          'nameEn': itemsRequest.nameEn,
          'descriptionEn': itemsRequest.descriptionEn,
          'nameAr': itemsRequest.nameAr,
          'descriptionAr': itemsRequest.descriptionAr,
          'unit': itemsRequest.unit,
          'price': itemsRequest.price,
          'quantity': 1,
          'type': itemsRequest.type,
          'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
              filename: fileResult!.files.first.name),
        },
        formData: true,
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        addItemsResponse = ItemsResponse.fromJson(myData);
        itemList.insert(0, addItemsResponse!.item!);
        listCount += 1;
        emit(AddItemsSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(AddItemsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddItemsErrorState());
      printError(e.toString());
    }
  }

  Future updateItems({
    required ItemsRequest itemsRequest,
    required int index,
  }) async {
    try {
      emit(UpdateLoadingState());
      await DioHelper.postData(
        url: EndPoints.updateItem,
        body: fileResult != null
            ? {
                'id': itemsRequest.id,
                'nameEn': itemsRequest.nameEn,
                'descriptionEn': itemsRequest.descriptionEn,
                'nameAr': itemsRequest.nameAr,
                'descriptionAr': itemsRequest.descriptionAr,
                'unit': itemsRequest.unit,
                'price': itemsRequest.price,
                'quantity': 1,
                'type': itemsRequest.type,
                'image': MultipartFile.fromBytes(fileResult!.files.first.bytes!,
                    filename: fileResult!.files.first.name),
              }
            : {
                'id': itemsRequest.id,
                'nameEn': itemsRequest.nameEn,
                'descriptionEn': itemsRequest.descriptionEn,
                'nameAr': itemsRequest.nameAr,
                'descriptionAr': itemsRequest.descriptionAr,
                'unit': itemsRequest.unit,
                'price': itemsRequest.price,
                'quantity': 1,
                'type': itemsRequest.type,
              },
        formData: true,
      ).then((value) {
        printSuccess(value.data.toString());
        updateItemsResponse = ItemsResponse.fromJson(value.data);
        itemList[index] = updateItemsResponse!.item!;
        emit(UpdateSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(UpdateErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateErrorState());
      printError(e.toString());
    }
  }

  Future deleteItems({required ItemsModel itemsModel}) async {
    try {
      emit(DeleteItemsLoadingState());
      await DioHelper.postData(
        url: EndPoints.deleteItem,
        body: {
          'id': itemsModel.id,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        deleteItemsResponse = ItemsResponse.fromJson(myData);
        itemList.remove(itemsModel);
        listCount -= 1;
        emit(DeleteItemsSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeleteItemsErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(DeleteItemsErrorState());
      printResponse(e.toString());
    }
  }

  Future updateItemsStatus({
    required ItemsRequest itemsRequest,
    required int index,
  }) async {
    try {
      emit(ChangeItemsLoadingState());
      await DioHelper.postData(
        url: EndPoints.changeItemStatus,
        body: {
          'id': itemsRequest.id,
          'active': itemsRequest.active,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        updateItemsStatusResponse = ItemsResponse.fromJson(myData);
        itemList[index].active = itemsRequest.active!;
        emit(ChangeItemsSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(ChangeItemsErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(ChangeItemsErrorState());
      printResponse(e.toString());
    }
  }
}
