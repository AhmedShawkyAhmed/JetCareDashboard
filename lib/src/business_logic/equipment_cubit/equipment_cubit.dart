import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/models/equipment_model.dart';
import 'package:jetboard/src/data/network/requests/equipment_request.dart';
import 'package:jetboard/src/data/network/responses/equipment_response.dart';

import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import '../../presentation/widgets/toast.dart';

part 'equipment_state.dart';

class EquipmentCubit extends Cubit<EquipmentState> {
  EquipmentCubit(this.networkService) : super(EquipmentInitial());
  NetworkService networkService;
  static EquipmentCubit get(context) => BlocProvider.of(context);

  EquipmentRespons? getEquipmentResponse,
      getActiveEquipmentResponse,
      addEquipmentResponse,
      deleteEquipmentResponse;
  List<EquipmentModel> equipmentList= [];
  List<int> equipmentIds= [];
  List<EquipmentModel> availableEquipmentList = [];
  int listCount = 0;
  int index = 0;



  Future getEquipment ({String? keyword,type,}) async {
    equipmentList.clear();
    getEquipmentResponse=null;
    listCount= 0;
    try {
      emit(GetEquipmentLoadingState());
      await networkService.get(
        url: EndPoints.getEquipment,
        query: {
          "keyword" : keyword,
          "type" : type,
        },
      ).then((value) {
        getEquipmentResponse = EquipmentRespons.fromJson(value.data);
        equipmentList.addAll(getEquipmentResponse!.equipmentModel!);
        listCount = getEquipmentResponse!.equipmentModel!.length;
        for(int e = 0; e < getEquipmentResponse!.equipmentModel!.length; e++){
            equipmentIds.add(getEquipmentResponse!.equipmentModel![e].id!);
        }
        emit(GetEquipmentSuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(GetEquipmentErrorState());
      printError(n.toString());
    } catch (e) {
      emit(GetEquipmentErrorState());
      printError(e.toString());
    }
  }

  Future getActiveEquipment ({String? keyword,type,required VoidCallback afterSuccess}) async {
    availableEquipmentList.clear();
    getActiveEquipmentResponse=null;
    try {
      emit(GetActiveEquipmentLoadingState());
      await networkService.get(
        url: EndPoints.getEquipment,
        query: {
          "keyword" : keyword,
          "type" : type,
        },
      ).then((value) {
        getActiveEquipmentResponse = EquipmentRespons.fromJson(value.data);
        for(int e = 0; e < getActiveEquipmentResponse!.equipmentModel!.length; e++){
          if(getActiveEquipmentResponse!.equipmentModel![e].active == 1){
            availableEquipmentList.add(getActiveEquipmentResponse!.equipmentModel![e]);
          }
        }
        emit(GetActiveEquipmentSuccessState());
        afterSuccess();
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(GetActiveEquipmentErrorState());
      printError(n.toString());
    } catch (e) {
      emit(GetActiveEquipmentErrorState());
      printError(e.toString());
    }
  }

  Future addEquipment({
    required EquipmentRequest equipmentRequest,
  }) async {
    printSuccess(equipmentRequest.code.toString());
    printSuccess(equipmentRequest.name.toString());
    try {
      emit(AddEquipmentLoadingState());
      await networkService.post(
        url: EndPoints.addEquipment,
        body: {
          'code': equipmentRequest.code,
          'name': equipmentRequest.name,
          }
      ).then((value) {
        getEquipment();
        printSuccess(value.toString());
        addEquipmentResponse = EquipmentRespons.fromJson(value.data);
        //equipmentList.addAll(addEquipmentResponse!.equipmentModel!);
        //listCount += 1;
        emit(AddEquipmentSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(AddEquipmentErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddEquipmentErrorState());
      printError(e.toString());
    }
  }

  Future deleteEquipment({required EquipmentModel equipmentModel}) async {
    try {
      emit(DeleteEquipmentLoadingState());
      await networkService.post(
        url: EndPoints.deleteEquipment,
        body: {
          'id': equipmentModel.id,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        deleteEquipmentResponse = EquipmentRespons.fromJson(myData);
        equipmentList.remove(equipmentModel);
        listCount -= 1;
        emit(DeleteEquipmentSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeleteEquipmentErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(DeleteEquipmentErrorState());
      printResponse(e.toString());
    }
  }
}
