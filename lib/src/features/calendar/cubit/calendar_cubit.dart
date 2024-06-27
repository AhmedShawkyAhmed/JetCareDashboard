import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/views/indicator_view.dart';
import 'package:jetboard/src/features/calendar/data/models/calendar_model.dart';
import 'package:jetboard/src/features/calendar/data/repo/calendar_repo.dart';
import 'package:jetboard/src/features/calendar/data/requests/calendar_request.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this.repo) : super(CalendarInitial());
  final CalendarRepo repo;

  List<CalendarModel>? calendar;

  Future getCalendar({
    int? month,
    int? year,
  }) async {
    emit(GetCalendarLoading());
    var response = await repo.getCalendar(
      month: month ?? DateTime.now().month,
      year: year ?? DateTime.now().year,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        calendar = response.data;
        emit(GetCalendarSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetCalendarFailure());
        error.showError();
      },
    );
  }

  Future addCalendarPeriod({
    required CalendarRequest request,
  }) async {
    IndicatorView.showIndicator();
    emit(AddCalendarLoading());
    var response = await repo.addCalendarPeriod(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        request.calendarModel!.area!.add(request.areaModel!);
        NavigationService.pop();
        NavigationService.pop();
        emit(AddCalendarSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AddCalendarFailure());
        error.showError();
      },
    );
  }

  Future deleteCalendarPeriod({
    required int id,
    required int index,
    required CalendarModel calendarModel,
  }) async {
    emit(DeleteCalendarLoading());
    var response = await repo.deleteCalendarPeriod(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        calendarModel.periods!.removeAt(index);
        emit(DeleteCalendarSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteCalendarFailure());
        error.showError();
      },
    );
  }
}
