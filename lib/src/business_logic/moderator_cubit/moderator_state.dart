part of 'moderator_cubit.dart';

@immutable
abstract class ModeratorState {}

class ModeratorInitial extends ModeratorState {}

class ChangePasswordState extends ModeratorState {}
class ModeratorSwitchState extends ModeratorState {}

class ModeratorLoadingState extends ModeratorState {}
class ModeratorSuccessState extends ModeratorState {}
class ModeratorErrorState extends ModeratorState {}

class ChangeModeratorLoadingState extends ModeratorState {}
class ChangeModeratorSuccessState extends ModeratorState {}
class ChangeModeratorErrorState extends ModeratorState {}

class AddModeratorLoadingState extends ModeratorState {}
class AddModeratorSuccessState extends ModeratorState {}
class AddModeratorErrorState extends ModeratorState {}

class UpdateModeratorLoadingState extends ModeratorState {}
class UpdateModeratorSuccessState extends ModeratorState {}
class UpdateModeratorErrorState extends ModeratorState {}

class DeleteModeratorLoadingState extends ModeratorState {}
class DeleteModeratorSuccessState extends ModeratorState {}
class DeleteModeratorErrorState extends ModeratorState {}

class CreateAccessLoadingState extends ModeratorState {}
class CreateAccessSuccessState extends ModeratorState {}
class CreateAccessErrorState extends ModeratorState {}

class UpdateAccessLoadingState extends ModeratorState {}
class UpdateAccessSuccessState extends ModeratorState {}
class UpdateAccessErrorState extends ModeratorState {}

class GetAccessLoadingState extends ModeratorState {}
class GetAccessSuccessState extends ModeratorState {}
class GetAccessErrorState extends ModeratorState {}

class ModeratorCommentLoadingState extends ModeratorState {}
class ModeratorCommentSuccessState extends ModeratorState {}
class ModeratorCommentErrorState extends ModeratorState {}
