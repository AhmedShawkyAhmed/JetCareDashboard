part of 'info_cubit.dart';

@immutable
abstract class InfoState {}

class InfoCubitInitial extends InfoState {}

class GetInfoLodingState extends InfoState {}

class GetInfoSuccessState extends InfoState {}

class GetInfoErrorState extends InfoState {}

class AddInfoLodingState extends InfoState {}

class AddInfoSuccessState extends InfoState {}

class AddInfoErrorState extends InfoState {}

class DeleteInfoLodingState extends InfoState {}

class DeleteInfoSuccessState extends InfoState {}

class DeleteInfoErrorState extends InfoState {}

class InfoTypeLodingState extends InfoState {}

class InfoTypeSuccessState extends InfoState {}

class InfoTypeErrorState extends InfoState {}
