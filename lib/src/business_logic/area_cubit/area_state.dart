part of 'area_cubit.dart';

@immutable
abstract class AreaState {
  final bool? isLoading;
  const AreaState({ this.isLoading});
}

class AreaInitial extends AreaState {}

class AreaLodingState extends AreaState {}

class AreaSuccessState extends AreaState {}

class AreaErrorState extends AreaState {}

class AddAreaLodingState extends AreaState {}

class AddAreaSuccessState extends AreaState {}

class AddAreaErrorState extends AreaState {}

class UpdateAreaLodingState extends AreaState {}

class UpdateAreaSuccessState extends AreaState {}

class UpdateAreaErrorState extends AreaState {}

class ChangeAreaLodingState extends AreaState {}

class ChangeAreaSuccessState extends AreaState {}

class ChangeAreaErrorState extends AreaState {}

class DeleteAreaLodingState extends AreaState {}

class DeleteAreaSuccessState extends AreaState {}

class DeleteAreaErrorState extends AreaState {}

class PickedSwitchState extends AreaState {}