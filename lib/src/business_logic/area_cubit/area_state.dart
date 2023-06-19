part of 'area_cubit.dart';

@immutable
abstract class AreaState {
  final bool? isLoading;
  const AreaState({ this.isLoading});
}

class AreaInitial extends AreaState {}

class AreaLoadingState extends AreaState {}

class AreaSuccessState extends AreaState {}

class AreaErrorState extends AreaState {}

class AddAreaLoadingState extends AreaState {}

class AddAreaSuccessState extends AreaState {}

class AddAreaErrorState extends AreaState {}

class UpdateAreaLoadingState extends AreaState {}

class UpdateAreaSuccessState extends AreaState {}

class UpdateAreaErrorState extends AreaState {}

class ChangeAreaLoadingState extends AreaState {}

class ChangeAreaSuccessState extends AreaState {}

class ChangeAreaErrorState extends AreaState {}

class DeleteAreaLoadingState extends AreaState {}

class DeleteAreaSuccessState extends AreaState {}

class DeleteAreaErrorState extends AreaState {}

class PickedSwitchState extends AreaState {}