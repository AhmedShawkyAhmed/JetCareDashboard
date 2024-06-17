part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class StatisticsLoading extends HomeState {}
class StatisticsSuccess extends HomeState {}
class StatisticsFailure extends HomeState {}
