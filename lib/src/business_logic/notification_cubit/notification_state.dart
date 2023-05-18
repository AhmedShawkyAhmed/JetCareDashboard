part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class SaveNotificationLoadingState extends NotificationState {}
class SaveNotificationSuccessState extends NotificationState {}
class SaveNotificationErrorState extends NotificationState {}

class GetNotificationLoadingState extends NotificationState {}
class GetNotificationSuccessState extends NotificationState {}
class GetNotificationErrorState extends NotificationState {}

class ReadNotificationLoadingState extends NotificationState {}
class ReadNotificationSuccessState extends NotificationState {}
class ReadNotificationErrorState extends NotificationState {}
