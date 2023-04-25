part of 'calendar_cubit.dart';

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLodingState extends CalendarState {}

class CalendarSuccessState extends CalendarState {}

class CalendarErrorState extends CalendarState {}

class AddCalendarLodingState extends CalendarState {}

class AddCalendarSuccessState extends CalendarState {}

class AddCalendarErrorState extends CalendarState {}

class AddCalendarPeriodLodingState extends CalendarState {}

class AddCalendarPeriodSuccessState extends CalendarState {}

class AddCalendarPeriodErrorState extends CalendarState {}

class UpdateCalendarLodingState extends CalendarState {}

class UpdateCalendarSuccessState extends CalendarState {}

class UpdateCalendarErrorState extends CalendarState {}

class DeleteCalendarLodingState extends CalendarState {}

class DeleteCalendarSuccessState extends CalendarState {}

class DeleteCalendarErrorState extends CalendarState {}
