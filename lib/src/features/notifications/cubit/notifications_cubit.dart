import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/features/notifications/data/models/notification_model.dart';
import 'package:jetboard/src/features/notifications/data/repo/notification_repo.dart';
import 'package:jetboard/src/features/notifications/data/requests/notification_request.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.repo) : super(NotificationsInitial());
  final NotificationRepo repo;

  List<NotificationModel>? notifications;

  Future getNotifications() async {
    emit(GetNotificationsLoading());
    var response = await repo.getNotifications();
    response.when(
      success: (NetworkBaseModel response) async {
        notifications = response.data;
        emit(GetNotificationsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetNotificationsFailure());
        error.showError();
      },
    );
  }

  Future notifyUser({
    required NotificationRequest request,
  }) async {
    emit(NotifyUserLoading());
    var response = await repo.notifyUser(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        await saveNotification(request: request);
        emit(NotifyUserSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(NotifyUserFailure());
        error.showError();
      },
    );
  }

  Future notifyAll({
    required NotificationRequest request,
  }) async {
    emit(NotifyAllLoading());
    var response = await repo.notifyAll(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (notifications != null) {
          notifications?.insert(
            0,
            NotificationModel(
              id: request.userId,
              title: request.title,
              message: request.message,
            ),
          );
        }
        NavigationService.pop();
        // await saveNotification(request: request);
        emit(NotifyAllSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(NotifyAllFailure());
        error.showError();
      },
    );
  }

  Future saveNotification({
    required NotificationRequest request,
  }) async {
    emit(SaveNotificationsLoading());
    var response = await repo.saveNotification(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        getNotifications();
        emit(SaveNotificationsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(SaveNotificationsFailure());
        error.showError();
      },
    );
  }
}
