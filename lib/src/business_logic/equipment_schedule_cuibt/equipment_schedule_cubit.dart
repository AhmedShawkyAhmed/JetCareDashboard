import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/models/equipment_schedule_model.dart';
import 'package:jetboard/src/data/network/responses/equipment_schedule_responses.dart';

import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../presentation/widgets/toast.dart';

part 'equipment_schedule_state.dart';

class EquipmentScheduleCubit extends Cubit<EquipmentScheduleState> {
  EquipmentScheduleCubit() : super(EquipmentInitial());

  static EquipmentScheduleCubit get(context) => BlocProvider.of(context);

  EquipmentScheduleResponse? getEquipmentScheduleResponse,
      addEquipmentScheduleRDateResponse;
  List<EquipmentScheduleModel> equipmentList= [];
  int listCount = 0;




  Future getEquipmentSchedule ({String? keyword,type,}) async {
    equipmentList.clear();
    getEquipmentScheduleResponse=null;
    listCount= 0;
    try {
      emit(GetEquipmentLoadingState());
      await DioHelper.getData(
        url: EndPoints.getEquipmentSchedule,
        query: {
          "keyword" : keyword,
          "type" : type,
        },
      ).then((value) {
        getEquipmentScheduleResponse = EquipmentScheduleResponse.fromJson(value.data);
        equipmentList.addAll(getEquipmentScheduleResponse!.equipmentScheduleModel!);
        listCount = getEquipmentScheduleResponse!.equipmentScheduleModel!.length;
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

  Future assignEquipment({
    required int eqId,
    required int crewId,
    required String date,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(AddEquipmentLoadingState());
      await DioHelper.postData(
        url: EndPoints.assignEquipment,
        body: {
          'eqId': eqId,
          'crewId': crewId,
          'date': date,
          }
      ).then((value) {
        printSuccess(value.toString());
        if(value.data['status'] == 200){
          getEquipmentSchedule();
        }
        emit(AddEquipmentSuccessState());
        afterSuccess();
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

  Future addReturnDate({
    required int id,
    required String date,
    required VoidCallback afterSuccess,
  }) async {
     try {
      printLog(id.toString());
      printLog(date.toString());
      emit(AddEquipmentReturnedDateLoadingState());
      await DioHelper.postData(
        url: EndPoints.returnDate,
        body: {
          'id':id,
          'date': date,
          }
      ).then((value) {
        printSuccess(value.toString());
        addEquipmentScheduleRDateResponse = EquipmentScheduleResponse.fromJson(value.data);
        emit(AddEquipmentReturnedDateSuccessState());
        afterSuccess();
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(AddEquipmentReturnedDateErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddEquipmentReturnedDateErrorState());
      printError(e.toString());
    }
  }


}
