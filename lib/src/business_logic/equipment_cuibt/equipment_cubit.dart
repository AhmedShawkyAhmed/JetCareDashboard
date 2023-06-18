import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/models/equipment_model.dart';
import 'package:jetboard/src/data/network/requests/equipment_request.dart';
import 'package:jetboard/src/data/network/responses/equipment_response.dart';

import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../presentation/widgets/toast.dart';

part 'equipment_state.dart';

class EquipmentCubit extends Cubit<EquipmentState> {
  EquipmentCubit() : super(EquipmentInitial());

  static EquipmentCubit get(context) => BlocProvider.of(context);

  EquipmentRespons? getEquipmentResponse,
      addEquipmentResponse,
      deleteEquipmentResponse;
  List<EquipmentModel> equipmentList= [];
  int listCount = 0;
  int index = 0;



  Future getEquipment ({String? keyword,type,}) async {
    equipmentList.clear();
    getEquipmentResponse=null;
    listCount= 0;
    try {
      emit(GetEquipmentLoadingState());
      await DioHelper.getData(
        url: EndPoints.getEquipment,
        query: {
          "keyword" : keyword,
          "type" : type,
        },
      ).then((value) {
        getEquipmentResponse = EquipmentRespons.fromJson(value.data);
        equipmentList.addAll(getEquipmentResponse!.equipmentModel!);
        listCount = getEquipmentResponse!.equipmentModel!.length;
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

  Future addEquipment({
    required EquipmentRequest equipmentRequest,
  }) async {
    printSuccess(equipmentRequest.code.toString());
    printSuccess(equipmentRequest.name.toString());
    try {
      emit(AddEquipmentLoadingState());
      await DioHelper.postData(
        url: EndPoints.addEquipment,
        body: {
          'code': equipmentRequest.code,
          'name': equipmentRequest.name,
          }
      ).then((value) {
        getEquipment();
        printSuccess(value.toString());
        final myData = Map<String, dynamic>.from(value.data);
        addEquipmentResponse = EquipmentRespons.fromJson(myData);
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
      await DioHelper.postData(
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
