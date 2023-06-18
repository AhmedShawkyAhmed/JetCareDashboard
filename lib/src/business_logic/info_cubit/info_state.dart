part of 'info_cubit.dart';

@immutable
abstract class InfoState {}

class InfoCubitInitial extends InfoState {}

class GetInfoLoadingState extends InfoState {}

class GetInfoSuccessState extends InfoState {}

class GetInfoErrorState extends InfoState {}

class AddInfoLoadingState extends InfoState {}

class AddInfoSuccessState extends InfoState {}

class AddInfoErrorState extends InfoState {}

class DeleteInfoLoadingState extends InfoState {}

class DeleteInfoSuccessState extends InfoState {}

class DeleteInfoErrorState extends InfoState {}

class InfoTypeLoadingState extends InfoState {}

class InfoTypeSuccessState extends InfoState {}

class InfoTypeErrorState extends InfoState {}
