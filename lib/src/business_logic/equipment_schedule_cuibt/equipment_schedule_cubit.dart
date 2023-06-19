import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/models/equipment_schedule_model.dart';
import 'package:jetboard/src/data/network/requests/equipment_schedule_request.dart';
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
      addEquipmentScheduleResponse,
      addEquipmentScheduleRDateResponse,
      deleteEquipmentScheduleResponse;
  List<EquipmentScheduleModel> equipmentList= [];
  int listCount = 0;
  int index = 0;




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

  // Future addEquipment({
  //   required EquipmentScheduleRequest equipmentScheduleRequest,
  // }) async {
  //   printSuccess(equipmentScheduleRequest.equipment!.code.toString());
  //   printSuccess(equipmentScheduleRequest.equipment!.name.toString());
  //   try {
  //     emit(AddEquipmentLoadingState());
  //     await DioHelper.postData(
  //       url: EndPoints.addEquipment,
  //       body: {
  //         'code': equipmentScheduleRequest.equipment!.code,
  //         'name': equipmentScheduleRequest.equipment!.name,
  //         }
  //     ).then((value) {
  //       getEquipment();
  //       printSuccess(value.toString());
  //       final myData = Map<String, dynamic>.from(value.data);
  //       addEquipmentResponse = EquipmentRespons.fromJson(myData);
  //       //equipmentList.addAll(addEquipmentResponse!.equipmentModel!);
  //       //listCount += 1;
  //       emit(AddEquipmentSuccessState());
  //       DefaultToast.showMyToast(value.data['message']);
  //     });
  //   } on DioError catch (n) {
  //     emit(AddEquipmentErrorState());
  //     printError(n.toString());
  //   } catch (e) {
  //     emit(AddEquipmentErrorState());
  //     printError(e.toString());
  //   }
  // }

  Future addReturnDate({
    required EquipmentScheduleRequest equipmentScheduleRequest,
  }) async {
    try {
      print(equipmentScheduleRequest.id);
      emit(AddEquipmentReturnedDateLoadingState());
      await DioHelper.postData(
        url: EndPoints.returnDate,
        body: {
          'id':equipmentScheduleRequest.id,
          'date': equipmentScheduleRequest.returned,
          }
      ).then((value) {
        printSuccess(value.toString());
        final myData = Map<String, dynamic>.from(value.data);
        addEquipmentScheduleRDateResponse = EquipmentScheduleResponse.fromJson(myData);
        emit(AddEquipmentReturnedDateSuccessState());
        DefaultToast.showMyToast(value.data['message']);
        //getEquipmentSchedule();
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
