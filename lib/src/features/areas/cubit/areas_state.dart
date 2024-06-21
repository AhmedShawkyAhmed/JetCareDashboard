part of 'areas_cubit.dart';

@immutable
sealed class AreasState {}

final class AreasInitial extends AreasState {}

class PickedSwitchState extends AreasState {}

class GetStatesLoading extends AreasState {}
class GetStatesSuccess extends AreasState {}
class GetStatesFailure extends AreasState {}

class GetAreasLoading extends AreasState {}
class GetAreasSuccess extends AreasState {}
class GetAreasFailure extends AreasState {}

class GetAreasOfStateLoading extends AreasState {}
class GetAreasOfStateSuccess extends AreasState {}
class GetAreasOfStateFailure extends AreasState {}

class AddAreaLoading extends AreasState {}
class AddAreaSuccess extends AreasState {}
class AddAreaFailure extends AreasState {}

class UpdateAreaLoading extends AreasState {}
class UpdateAreaSuccess extends AreasState {}
class UpdateAreaFailure extends AreasState {}

class ChangeAreaStatusLoading extends AreasState {}
class ChangeAreaStatusSuccess extends AreasState {}
class ChangeAreaStatusFailure extends AreasState {}

class DeleteAreaLoading extends AreasState {}
class DeleteAreaSuccess extends AreasState {}
class DeleteAreaFailure extends AreasState {}
