import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/data/models/calender_model.dart';
import 'package:jetboard/src/data/network/requests/calender_request.dart';
import 'package:jetboard/src/data/network/responses/calender_response.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';

import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/network/end_points.dart';

part 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit(this.networkService) : super(CalenderInitial());
  NetworkService networkService;

  static CalenderCubit get(context) => BlocProvider.of(context);

  GlobalResponse? addCalenderResponse, deleteCalenderResponse;
  CalenderResponse? calenderResponse;
  List<String> periods = [];
  List<CalenderModel> calenderList = [];

  Future getCalender({
    int? year,
    int? month,
    required VoidCallback afterSuccess,
  }) async {
    try {
      calenderList.clear();
      emit(GetCalenderInitial());
      await networkService.get(
        url: EndPoints.getCalender,
        query: {
          "month": month ?? DateTime.now().month.toString(),
          "year": year ?? DateTime.now().year.toString(),
        },
      ).then((value) {
        calenderResponse = CalenderResponse.fromJson(value.data);
        calenderList.addAll(calenderResponse!.calenderModel!);
        emit(GetCalenderSuccess());
        printSuccess(value.data.toString());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(GetCalenderError());
      printError(n.toString());
    } catch (e) {
      emit(GetCalenderError());
      printError(e.toString());
    }
  }

  Future createCalenderPeriod({
    required CalenderRequest calenderRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(CreateCalenderInitial());
      await networkService.post(
        url: EndPoints.createCalenderPeriod,
        body: {
          'calenderId': calenderRequest.calenderId,
          'periodId': calenderRequest.periodId,
          'areaId': calenderRequest.areaId,
        },
      ).then((value) {
        DefaultToast.showMyToast(value.data['message']);
        printLog(value.data['message']);
        emit(CreateCalenderSuccess());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(CreateCalenderError());
      printError(n.toString());
    } catch (e) {
      emit(CreateCalenderError());
      printError(e.toString());
    }
  }

  Future deleteCalenderPeriod({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DeleteCalenderInitial());
      await networkService.post(
        url: EndPoints.deleteCalenderPeriod,
        body: {
          'id': id,
        },
      ).then((value) {
        printLog(value.data['message']);
        emit(DeleteCalenderSuccess());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(DeleteCalenderError());
      printError(n.toString());
    } catch (e) {
      emit(DeleteCalenderError());
      printError(e.toString());
    }
  }
}
