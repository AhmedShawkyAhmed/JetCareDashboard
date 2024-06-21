part of 'info_cubit.dart';

@immutable
sealed class InfoState {}

final class InfoInitial extends InfoState {}

class GetInfoLoading extends InfoState {}
class GetInfoSuccess extends InfoState {}
class GetInfoFailure extends InfoState {}

class GetTypesLoading extends InfoState {}
class GetTypesSuccess extends InfoState {}
class GetTypesFailure extends InfoState {}

class GetUnitLoading extends InfoState {}
class GetUnitSuccess extends InfoState {}
class GetUnitFailure extends InfoState {}

class GetRoleLoading extends InfoState {}
class GetRoleSuccess extends InfoState {}
class GetRoleFailure extends InfoState {}

class GetCategoryLoading extends InfoState {}
class GetCategorySuccess extends InfoState {}
class GetCategoryFailure extends InfoState {}

class GetItemsTypesLoading extends InfoState {}
class GetItemsTypesSuccess extends InfoState {}
class GetItemsTypesFailure extends InfoState {}

class AddInfoLoading extends InfoState {}
class AddInfoSuccess extends InfoState {}
class AddInfoFailure extends InfoState {}

class UpdateInfoLoading extends InfoState {}
class UpdateInfoSuccess extends InfoState {}
class UpdateInfoFailure extends InfoState {}

class DeleteInfoLoading extends InfoState {}
class DeleteInfoSuccess extends InfoState {}
class DeleteInfoFailure extends InfoState {}
