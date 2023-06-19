part of 'calendar_cubit.dart';

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoadingState extends CalendarState {}

class CalendarSuccessState extends CalendarState {}

class CalendarErrorState extends CalendarState {}

class AddCalendarLoadingState extends CalendarState {}

class AddCalendarSuccessState extends CalendarState {}

class AddCalendarErrorState extends CalendarState {}

class AddCalendarPeriodLoadingState extends CalendarState {}

class AddCalendarPeriodSuccessState extends CalendarState {}

class AddCalendarPeriodErrorState extends CalendarState {}

class UpdateCalendarLoadingState extends CalendarState {}

class UpdateCalendarSuccessState extends CalendarState {}

class UpdateCalendarErrorState extends CalendarState {}

class DeleteCalendarLoadingState extends CalendarState {}

class DeleteCalendarSuccessState extends CalendarState {}

class DeleteCalendarErrorState extends CalendarState {}
