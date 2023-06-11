import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/network/responses/crew_area_response.dart';

part 'crew_state.dart';

class CrewCubit extends Cubit<CrewState> {
  CrewCubit() : super(CrewInitial());

  static CrewCubit get(context) => BlocProvider.of(context);

  CrewAreaResponse? crewAreaResponse;
  List<int> areaIds = [];
  List<int> crewAreasIds = [];

  Future getArea({
    required int crewId,
    required VoidCallback afterSuccess,
  }) async {
    areaIds.clear();
    crewAreasIds.clear();
    try {
      emit(CrewAreaLoading());
      await DioHelper.getData(
        url: EndPoints.getCrewAreas,
        query: {
          "crewId": crewId,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        crewAreaResponse = CrewAreaResponse.fromJson(value.data);
        for (int a = 0; a < crewAreaResponse!.areas!.length; a++) {
          areaIds.add(crewAreaResponse!.areas![a].area!.id);
          crewAreasIds.add(crewAreaResponse!.areas![a].id!);
        }
        emit(CrewAreaSuccess());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(CrewAreaError());
      printError(n.toString());
    } catch (e) {
      emit(CrewAreaError());
      printError(e.toString());
    }
  }

  Future addArea({
    required int crewId,
    required int areaId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(AddCrewAreaLoading());
      await DioHelper.postData(
        url: EndPoints.addAreaToCrew,
        body: {
          'crewId': crewId,
          'areaId': areaId,
        },
      ).then((value) {
        printLog(value.data['message']);
        printLog(value.data['id'].toString());
        crewAreasIds.insert(0,value.data['id']);
        emit(AddCrewAreaSuccess());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(AddCrewAreaError());
      printError(n.toString());
    } catch (e) {
      emit(AddCrewAreaError());
      printError(e.toString());
    }
  }

  Future deleteArea({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DeleteCrewAreaLoading());
      await DioHelper.postData(
        url: EndPoints.deleteCrewArea,
        body: {
          'id': id,
        },
      ).then((value) {
        printLog(value.data['message']);
        emit(DeleteCrewAreaSuccess());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(DeleteCrewAreaError());
      printError(n.toString());
    } catch (e) {
      emit(DeleteCrewAreaError());
      printError(e.toString());
    }
  }
}
