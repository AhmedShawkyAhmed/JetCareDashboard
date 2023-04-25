part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class AppChangeSideNavBarState extends GlobalState {}

class AppChangeShadowState extends GlobalState {}

class AppChangeSwitchState extends GlobalState {}

class UserTypeLodingState extends GlobalState {}

class UserTypeSuccessState extends GlobalState {}

class UserTypeErrorState extends GlobalState {}

class PackagesLodingState extends GlobalState {}

class PackagesSuccessState extends GlobalState {}

class PackagesErrorState extends GlobalState {}

class ItemsForPackagesLodingState extends GlobalState {}

class ItemsForPackagesSuccessState extends GlobalState {}

class ItemsForPackagesErrorState extends GlobalState {}

class CrewLoadingState extends GlobalState {}

class CrewSuccessState extends GlobalState {}

class CrewErrorState extends GlobalState {}

class StatisticsLoadingState extends GlobalState {}
class StatisticsSuccessState extends GlobalState {}
class StatisticsErrorState extends GlobalState {}

class PeriodLodingState extends GlobalState {}
class PeriodSuccessState extends GlobalState {}
class PeriodErrorState extends GlobalState {}

class ClientsLoadingState extends GlobalState {}
class ClientsSuccessState extends GlobalState {}
class ClientsErrorState extends GlobalState {}

class ItemsLoadingState extends GlobalState {}
class ItemsSuccessState extends GlobalState {}
class ItemsErrorState extends GlobalState {}

