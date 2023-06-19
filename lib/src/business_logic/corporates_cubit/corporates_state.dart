part of 'corporates_cubit.dart';

@immutable
abstract class CorporatesState {}

class CorporatesInitial extends CorporatesState {}

class CorporatesLoadingState extends CorporatesState {}

class CorporatesSuccessState extends CorporatesState {}

class CorporatesErrorState extends CorporatesState {}

class ReadLoadingState extends CorporatesState {}

class ReadSuccessState extends CorporatesState {}

class ReadErrorState extends CorporatesState {}

class UpdateCorporateStatusLoadingState extends CorporatesState {}
class UpdateCorporateStatusSuccessState extends CorporatesState {}
class UpdateCorporateStatusErrorState extends CorporatesState {}

class CorporateItemsLoadingState extends CorporatesState {}
class CorporateItemsSuccessState extends CorporatesState {}
class CorporateItemsErrorState extends CorporatesState {}

class CreateCorporateLoadingState extends CorporatesState {}
class CreateCorporateSuccessState extends CorporatesState {}
class CreateCorporateErrorState extends CorporatesState {}
