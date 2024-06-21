part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

class GetNotificationsLoading extends NotificationsState {}
class GetNotificationsSuccess extends NotificationsState {}
class GetNotificationsFailure extends NotificationsState {}

class NotifyUserLoading extends NotificationsState {}
class NotifyUserSuccess extends NotificationsState {}
class NotifyUserFailure extends NotificationsState {}

class NotifyAllLoading extends NotificationsState {}
class NotifyAllSuccess extends NotificationsState {}
class NotifyAllFailure extends NotificationsState {}

class SaveNotificationsLoading extends NotificationsState {}
class SaveNotificationsSuccess extends NotificationsState {}
class SaveNotificationsFailure extends NotificationsState {}
