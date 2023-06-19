import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../data/models/calendar_model.dart';
import '../../data/network/requests/calendar_request.dart';
import '../../data/network/responses/calendar_response.dart';
import '../../presentation/widgets/toast.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());

  static CalendarCubit get(context) => BlocProvider.of(context);

  calendarResponse? getcalendarResponse,
      addcalendarResponse,
      deletecalendarResponse,
      updatecalendarResponse,
      updatecalendarStatusResponse;
  List<CalendarModel> calendarList = [];
  int listCount = 0;
  int index = 0;

  Future getcalendar({String? keyword, type}) async {
    calendarList.clear();
    listCount = 0;
    try {
      emit(CalendarLoadingState());
      await DioHelper.getData(
        url: EndPoints.getDates,
        query: {
          "keyword": keyword,
          "type": type,
        },
      ).then((value) {
        getcalendarResponse = calendarResponse.fromJson(value.data);
        calendarList.addAll(getcalendarResponse!.calendarModel!);
        listCount = getcalendarResponse!.calendarModel!.length;
        emit(CalendarSuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(CalendarErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CalendarErrorState());
      printError(e.toString());
    }
  }

  Future addcalendar({
    required CalendarRquest calendarRquest,
  }) async {
    try {
      emit(AddCalendarLoadingState());
      await DioHelper.postData(
        url: EndPoints.addDate,
        body: {
          'areaId': calendarRquest.areaId,
          'month': calendarRquest.month,
          'day': calendarRquest.day,
          'year': calendarRquest.year,
          'date': calendarRquest.date,
          'requests': calendarRquest.requests,
          'price': calendarRquest.price,
        },
      ).then((value) {
        printSuccess(value.toString());
        addcalendarResponse = calendarResponse.fromJson(value.data);
        getcalendar();
        emit(AddCalendarSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(AddCalendarErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddCalendarErrorState());
      printError(e.toString());
    }
  }

  Future updatecalendar({
    required CalendarRquest calendarRquest,
    required int index,
  }) async {
    try {
      emit(UpdateCalendarLoadingState());
      await DioHelper.postData(
        url: EndPoints.updateDate,
        body: {
          'id': calendarRquest.id,
          'areaId': calendarRquest.areaId,
          'month': calendarRquest.month,
          'year': calendarRquest.year,
          'date': calendarRquest.date,
          'requests': calendarRquest.requests,
          'price': calendarRquest.price,
        },
        formData: true,
      ).then((value) {
        updatecalendarResponse = calendarResponse.fromJson(value.data);
        emit(UpdateCalendarSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(UpdateCalendarErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateCalendarErrorState());
      printError(e.toString());
    }
  }

  Future deletecalendar({required CalendarModel calendarModel}) async {
    try {
      emit(DeleteCalendarLoadingState());
      await DioHelper.postData(
        url: EndPoints.deleteDate,
        body: {
          'id': calendarModel.id,
        },
      ).then((value) {
        deletecalendarResponse = calendarResponse.fromJson(value.data);
        calendarList.remove(calendarModel);
        listCount -= 1;
        emit(DeleteCalendarSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeleteCalendarErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeleteCalendarErrorState());
      printError(e.toString());
    }
  }
}
