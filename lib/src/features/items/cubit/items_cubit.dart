import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:jetboard/src/features/items/data/repo/items_repo.dart';
import 'package:jetboard/src/features/items/data/requests/item_request.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit(this.repo) : super(ItemsInitial());
  final ItemsRepo repo;

  List<ItemModel>? items;
  List<ItemModel>? corporates;
  List<ItemModel>? extras;
  FilePickerResult? fileResult;

  Future pickImage() async {
    emit(ItemPickedImageLoading());
    try {
      fileResult = await FilePicker.platform.pickFiles();
    } catch (e) {
      printError(e.toString());
    }
    if (fileResult != null) {
      emit(ItemPickedImageSuccess());
      printSuccess(fileResult!.files.first.name.toString());
    }
  }

  Future switched(ItemModel item) async {
    await changeItemStatus(
      request: ItemRequest(
        id: item.id,
        isActive: !item.isActive!,
      ),
    );
    emit(PickedSwitchState());
  }

  Future getData({
    required ItemTypes type,
    String? keyword,
  }) async {
    if (type == ItemTypes.item) {
      await getItems(keyword: keyword);
    }else if (type == ItemTypes.corporate) {
      await getCorporates(keyword: keyword);
    }else if (type == ItemTypes.extra) {
      await getExtras(keyword: keyword);
    }
  }

  Future getItems({
    String? keyword,
  }) async {
    emit(GetItemsLoading());
    var response = await repo.getItems(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        items = response.data;
        emit(GetItemsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetItemsFailure());
        error.showError();
      },
    );
  }

  Future getCorporates({
    String? keyword,
  }) async {
    emit(GetCorporateLoading());
    var response = await repo.getCorporates(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        corporates = response.data;
        emit(GetCorporateSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetCorporateFailure());
        error.showError();
      },
    );
  }

  Future getExtras({
    String? keyword,
  }) async {
    emit(GetExtrasLoading());
    var response = await repo.getExtras(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        extras = response.data;
        emit(GetExtrasSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetExtrasFailure());
        error.showError();
      },
    );
  }

  Future addItem({
    required ItemRequest request,
  }) async {
    emit(AddItemLoading());
    var response = await repo.addItem(
      request: request,
      image: File(fileResult!.files.first.name.toString()),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (request.type == ItemTypes.item) {
          if (items != null) {
            items!.add(response.data);
          }
        } else if (request.type == ItemTypes.corporate) {
          if (corporates != null) {
            corporates!.add(response.data);
          }
        } else if (request.type == ItemTypes.extra) {
          if (extras != null) {
            extras!.add(response.data);
          }
        }
        NavigationService.pop();
        emit(AddItemSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AddItemFailure());
        error.showError();
      },
    );
  }

  Future updateItem({
    required ItemRequest request,
  }) async {
    emit(UpdateItemLoading());
    var response = await repo.updateItem(
      request: request,
      image: File(fileResult?.files.first.name ?? ""),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        ItemModel? itemModel;
        if (request.type == ItemTypes.item) {
          itemModel = items!.firstWhere((item) => item.id == request.id);
        } else if (request.type == ItemTypes.corporate) {
          itemModel = corporates!.firstWhere((item) => item.id == request.id);
        } else if (request.type == ItemTypes.extra) {
          itemModel = extras!.firstWhere((item) => item.id == request.id);
        }
        if (itemModel != null) {
          itemModel.nameAr = request.nameAr;
          itemModel.nameEn = request.nameEn;
          itemModel.descriptionAr = request.descriptionAr;
          itemModel.descriptionEn = request.descriptionEn;
          itemModel.price = request.price;
          itemModel.unit = request.unit;
          itemModel.hasShipping = request.hasShipping;
          itemModel.quantity = request.quantity;
          itemModel.image = File(fileResult?.files.first.name ?? "").path;
        }

        emit(UpdateItemSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateItemFailure());
        error.showError();
      },
    );
  }

  Future changeItemStatus({
    required ItemRequest request,
  }) async {
    emit(UpdateItemLoading());
    var response = await repo.changeItemStatus(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (request.type == ItemTypes.item) {
          if (items != null) {
            items!.firstWhere((item) => item.id == request.id).isActive =
                request.isActive;
          }
        } else if (request.type == ItemTypes.corporate) {
          if (corporates != null) {
            corporates!.firstWhere((item) => item.id == request.id).isActive =
                request.isActive;
          }
        } else if (request.type == ItemTypes.extra) {
          if (extras != null) {
            extras!.firstWhere((item) => item.id == request.id).isActive =
                request.isActive;
          }
        }
        emit(UpdateItemSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateItemFailure());
        error.showError();
      },
    );
  }

  Future deleteItem({
    required ItemRequest request,
  }) async {
    emit(DeleteItemLoading());
    var response = await repo.deleteItem(
      id: request.id!,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (request.type == ItemTypes.item) {
          if (items != null) {
            items!.removeWhere((item) => item.id == request.id!);
          }
        } else if (request.type == ItemTypes.corporate) {
          if (corporates != null) {
            corporates!.removeWhere((item) => item.id == request.id!);
          }
        } else if (request.type == ItemTypes.extra) {
          if (extras != null) {
            extras!.removeWhere((item) => item.id == request.id!);
          }
        }
        emit(DeleteItemSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteItemFailure());
        error.showError();
      },
    );
  }
}
