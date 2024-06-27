part of 'calendar_cubit.dart';

@immutable
sealed class CalendarState {}

final class CalendarInitial extends CalendarState {}

class GetCalendarLoading extends CalendarState {}
class GetCalendarSuccess extends CalendarState {}
class GetCalendarFailure extends CalendarState {}

class AddCalendarLoading extends CalendarState {}
class AddCalendarSuccess extends CalendarState {}
class AddCalendarFailure extends CalendarState {}

class DeleteCalendarLoading extends CalendarState {}
class DeleteCalendarSuccess extends CalendarState {}
class DeleteCalendarFailure extends CalendarState {}
