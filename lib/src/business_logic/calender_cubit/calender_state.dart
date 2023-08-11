part of 'calender_cubit.dart';

@immutable
abstract class CalenderState {}

class CalenderInitial extends CalenderState {}

class GetCalenderInitial extends CalenderState {}
class GetCalenderSuccess extends CalenderState {}
class GetCalenderError extends CalenderState {}

class CreateCalenderInitial extends CalenderState {}
class CreateCalenderSuccess extends CalenderState {}
class CreateCalenderError extends CalenderState {}

class DeleteCalenderInitial extends CalenderState {}
class DeleteCalenderSuccess extends CalenderState {}
class DeleteCalenderError extends CalenderState {}

class PeriodCalenderInitial extends CalenderState {}
class PeriodCalenderSuccess extends CalenderState {}
class PeriodCalenderError extends CalenderState {}

class AreaCalenderInitial extends CalenderState {}
class AreaCalenderSuccess extends CalenderState {}
class AreaCalenderError extends CalenderState {}
