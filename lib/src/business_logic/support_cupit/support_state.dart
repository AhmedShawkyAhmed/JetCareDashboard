part of 'support_cubit.dart';

@immutable
abstract class SupportState {}

class SupportCupitInitial extends SupportState {}

class SupportSwitchState extends SupportState {}

class SupportLodingState extends SupportState {}

class SupportSuccessState extends SupportState {}

class SupportErrorState extends SupportState {}

class DeleteLodingState extends SupportState {}

class DeleteSuccessState extends SupportState {}

class DeleteErrorState extends SupportState {}

class ChangeSupportLodingState extends SupportState {}

class ChangeSupportSuccessState extends SupportState {}

class ChangeSupportErrorState extends SupportState {}
