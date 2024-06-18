import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/network/requests/period_request.dart';
import 'package:jetboard/src/data/network/responses/period_response.dart';
import 'package:meta/meta.dart';

import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import '../../data/models/period_model.dart';
import '../../core/shared/widgets/toast.dart';

part 'period_state.dart';

class PeriodCubit extends Cubit<PeriodState> {
  PeriodCubit(this.networkService) : super(PeriodInitial());
  NetworkService networkService;
  static PeriodCubit get(context) => BlocProvider.of(context);
  PeriodResponse? getPeriodResponse,
      addPeriodResponse,
      deletePeriodResponse,
      deletePeriodItemsResponse,
      updatePeriodResponse,
      updatePeriodStatusResponse;
  List<PeriodModel> periodList= [];
  int listCount = 0;
  int index = 0;


  void switched(int index) {
    periodList[index].active == 1
        ? periodList[index].active = 0
        : periodList[index].active = 1;
    emit(PickedSwitchState());
  }


  Future getPeriod ({String? keyword,type,}) async {
    periodList.clear();
    listCount= 0;
    try {
      emit(PeriodLoadingState());
      await networkService.get(
        url: EndPoints.getPeriods,
        query: {
          "keyword" : keyword,
          "type" : type,
        },
      ).then((value) {
        getPeriodResponse = PeriodResponse.fromJson(value.data);
        periodList.addAll(getPeriodResponse!.periodModel!);
        listCount = getPeriodResponse!.periodModel!.length;
        emit(PeriodLoadingState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(PeriodLoadingState());
      printError(n.toString());
    } catch (e) {
      emit(PeriodLoadingState());
      printError(e.toString());
    }
  }


  Future addPeriod({
    required PeriodRequest periodRequest,
  }) async {
    printSuccess(periodRequest.from.toString());
    printSuccess(periodRequest.to.toString());
    try {
      emit(AddPeriodLoadingState());
      await networkService.post(
        url: EndPoints.addPeriod,
        body: {
          'from': periodRequest.from,
          'to': periodRequest.to,
          }
      ).then((value) {
        printSuccess(value.toString());
        final myData = Map<String, dynamic>.from(value.data);
        addPeriodResponse = PeriodResponse.fromJson(myData);
        periodList.insert(0, addPeriodResponse!.periodModell!);
        listCount += 1;
        emit(AddPeriodSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(AddPeriodErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddPeriodErrorState());
      printError(e.toString());
    }
  }
  

  Future updatePeriod({
    required PeriodRequest periodRequest,
    required int index,
  }) async {
    try {
      emit(UpdatePeriodLoadingState());
      await networkService.post(
        url: EndPoints.updatePeriod,
        body:  {
                'id': periodRequest.id,
                'from': periodRequest.from,
                'to': periodRequest.to,
              },
      ).then((value) {
        printSuccess(value.data.toString());
        final myData = Map<String, dynamic>.from(value.data);
        updatePeriodResponse = PeriodResponse.fromJson(myData);
        periodList[index] = updatePeriodResponse!.periodModell!;
        emit(UpdatePeriodSuccessState());
        printSuccess(updatePeriodResponse!.periodModell!.toString());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(UpdatePeriodErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdatePeriodErrorState());
      printError(e.toString());
    }
  }

  Future updatePeriodStatus({
    required PeriodRequest periodRequest,
    required int indexs,
  }) async {
    try {
      emit(ChangePeriodLoadingState());
      await networkService.post(
        url: EndPoints.changePeriodStatus,
        body: {
          'id': periodRequest.id,
          'active': periodRequest.active,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        updatePeriodStatusResponse = PeriodResponse.fromJson(myData);
        periodList[indexs].active = periodRequest.active!;
        emit(ChangePeriodSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(ChangePeriodErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(ChangePeriodErrorState());
      printResponse(e.toString());
    }
  }


  Future deletePeriod({required PeriodModel periodModel}) async {
    try {
      emit(DeletePeriodLoadingState());
      await networkService.post(
        url: EndPoints.deletePeriod,
        body: {
          'id': periodModel.id,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        deletePeriodResponse = PeriodResponse.fromJson(myData);
        periodList.remove(periodModel);
        listCount -= 1;
        emit(DeletePeriodSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeletePeriodErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(DeletePeriodErrorState());
      printResponse(e.toString());
    }
  }
}
