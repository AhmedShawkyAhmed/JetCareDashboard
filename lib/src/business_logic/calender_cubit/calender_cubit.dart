import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/models/calender_model.dart';
import 'package:jetboard/src/data/network/requests/calender_request.dart';
import 'package:jetboard/src/data/network/responses/calender_response.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';

import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../data/network/responses/area_response.dart';
import '../../data/network/responses/period_response.dart';

part 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit() : super(CalenderInitial());

  static CalenderCubit get(context) => BlocProvider.of(context);

  GlobalResponse? addCalenderResponse, deleteCalenderResponse;
  CalenderResponse? calenderResponse;
  PeriodResponse? periodResponse;
  AreaResponse? areaResponse;
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
      await DioHelper.getData(
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
      await DioHelper.postData(
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
      await DioHelper.postData(
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

  Future getPeriods() async {
    try {
      emit(PeriodCalenderInitial());
      await DioHelper.getData(
        url: EndPoints.getPeriodsMobile,
      ).then((value) {
        periodResponse = PeriodResponse.fromJson(value.data);
        emit(PeriodCalenderSuccess());
        for (int i = 0; i < periodResponse!.periodModel!.length; i++) {
          periods.add(
              "${periodResponse!.periodModel![i].from} - ${periodResponse!.periodModel![i].to}");
        }
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(PeriodCalenderError());
      printError(n.toString());
    } catch (e) {
      emit(PeriodCalenderError());
      printError(e.toString());
    }
  }

  Future getArea() async {
    try {
      emit(AreaCalenderInitial());
      await DioHelper.getData(
        url: EndPoints.getAllAreas,
      ).then((value) {
        printSuccess(value.data.toString());
        areaResponse = AreaResponse.fromJson(value.data);
        emit(AreaCalenderSuccess());
      });
    } on DioError catch (n) {
      emit(AreaCalenderError());
      printError(n.toString());
    } catch (e) {
      emit(AreaCalenderError());
      printError(e.toString());
    }
  }
}
